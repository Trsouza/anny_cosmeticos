
import 'package:anny_cosmeticos/dados/dados_produto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProdutoCarrinho{

  String idProduto, categoria, idProdutoCarrinho;
  int qtd;

  DadosProduto produto;

  ProdutoCarrinho();

  ProdutoCarrinho.fromDocument(DocumentSnapshot doc){
    idProdutoCarrinho = doc.documentID;
    categoria = doc.data["categoria"];
    qtd = doc.data["qtd"];
    idProduto = doc.data["idProduto"];
  }

  Map<String, dynamic>mapear(){
    return{
      "categoria": categoria,
      "idProduto": idProduto,
      "qtd": qtd,
       "produto": produto.resumoCompra()
    };
  }

  
  
}