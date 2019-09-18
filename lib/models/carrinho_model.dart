import 'package:anny_cosmeticos/dados/produto_carrinho.dart';
import 'package:anny_cosmeticos/models/usuario_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CarrinhoModel extends Model {
  UsuarioModel usuarioModel;
  List<ProdutoCarrinho> produtos = [];
  String cupomDesconto;
  int porcentagemDesconto = 0;

  CarrinhoModel(this.usuarioModel) {
    if (usuarioModel.usuarioLogado()) _carregarItens();
  }
  bool carregando = false;

  // para acessar de qualquer lugar o CarrinhoModel
  static CarrinhoModel of(BuildContext context) =>
      ScopedModel.of<CarrinhoModel>(context);

  void adicionarItem(ProdutoCarrinho produtoCarrinho) {
    produtos.add(produtoCarrinho);

    Firestore.instance
        .collection("usuarios")
        .document(usuarioModel.firebaseUser.uid)
        .collection("carrinho")
        .add(produtoCarrinho.mapear())
        .then((doc) {
      produtoCarrinho.idProdutoCarrinho = doc.documentID;
    });
    notifyListeners();
  }

  void removeItemCarrinho(ProdutoCarrinho produtoCarrinho) {
    Firestore.instance
        .collection("usuarios")
        .document(usuarioModel.firebaseUser.uid)
        .collection("carrinho")
        .document(produtoCarrinho.idProdutoCarrinho)
        .delete();

    produtos.remove(produtoCarrinho);
    notifyListeners();
  }

  void incrementarProduto(ProdutoCarrinho pCa) {
    pCa.qtd++;

    Firestore.instance
        .collection("usuarios")
        .document(usuarioModel.firebaseUser.uid)
        .collection("carrinho");

    notifyListeners();
  }

  void decrementarProduto(ProdutoCarrinho pCa) {
    pCa.qtd--;

    Firestore.instance
        .collection("usuarios")
        .document(usuarioModel.firebaseUser.uid)
        .collection("carrinho");

    notifyListeners();
  }

  void _carregarItens() async {
    QuerySnapshot query = await Firestore.instance
        .collection("usuarios")
        .document(usuarioModel.firebaseUser.uid)
        .collection("carrinho")
        .getDocuments();

    produtos = query.documents
        .map((doc) => ProdutoCarrinho.fromDocument(doc))
        .toList();
  }

  void setarCupom(String cupom, int porcentagem) {
    this.porcentagemDesconto = porcentagem;
    this.cupomDesconto = cupom;
  }

  double getPrecosProdutos() {
    double preco = 0.0;
    for (ProdutoCarrinho p in produtos) {
      if (p.produto != null) {
        preco += p.qtd * p.produto.preco;
      }
    }
    return preco;
  }

  double getDesconto() {
    return getPrecosProdutos() * porcentagemDesconto / 100;
  }

  double getFrete() {
    return 15.00;
  }

  void atualizarPrecos() {
    notifyListeners();
  }

  Future<String>todosPedidos() async{
    if (produtos.length == 0) return null;

    carregando = true;
    notifyListeners();

    double preco = getPrecosProdutos();
    double desconto = getDesconto();
    double frete = getFrete();

    DocumentReference doc = await
    Firestore.instance.collection("todos_pedidos").add(
      {
        "idCliente" :usuarioModel.firebaseUser.uid,
        "produtos": produtos.map((produtosCarrinho)=> produtosCarrinho.mapear()).toList(),
         "frete": frete,
        "preco": preco,
        "desconto": desconto,
        "totalC": preco-desconto+frete,
        "status":1
      }
    );

    await Firestore.instance.collection("usuarios").document(usuarioModel.firebaseUser.uid)
      .collection("todos_pedidos").document(doc.documentID).setData(
        {"todos_produtos": doc.documentID}
      );

      QuerySnapshot query = await Firestore.instance.collection("usuarios")
        .document(usuarioModel.firebaseUser.uid).collection("carrinho").getDocuments();

        for(DocumentSnapshot doc2 in query.documents){
          doc2.reference.delete();
        }

        produtos.clear();
        cupomDesconto = null;
        porcentagemDesconto = 0;
        carregando = false;
        notifyListeners();

        return doc.documentID;
  }
}
