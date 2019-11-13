import 'package:anny_cosmeticos/dados/dados_produto.dart';
import 'package:anny_cosmeticos/dados/produto_carrinho.dart';
import 'package:anny_cosmeticos/models/carrinho_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//Representa cada item do carrinho

class CarrinhoTile extends StatelessWidget {
  final ProdutoCarrinho produtoCarrinho;

  CarrinhoTile(this.produtoCarrinho);

  @override
  Widget build(BuildContext context) {
    Widget _builderContent() {
      CarrinhoModel.of(context).atualizarPrecos();
      return Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8.0),
            width: 120.0,
            child: Image.network(
              produtoCarrinho.produto.imagens[0],
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, //alinha a esquerda
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, //espaçamento igual na vertical
                children: <Widget>[
                  Text(
                    produtoCarrinho.produto.titulo,
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 17.0),
                  ),
                  // Text("Tamanho: ${produtoCarrinho.size}")
                  Text(
                    "R\$ ${produtoCarrinho.produto.preco.toStringAsFixed(2)}",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.remove),
                        color: Theme.of(context).primaryColor,
                        onPressed: produtoCarrinho.qtd > 1 ? () {
                          CarrinhoModel.of(context).decrementarProduto(produtoCarrinho);
                        } : null,
                      ),
                      Text(produtoCarrinho.qtd.toString()),
                      IconButton(
                        icon: Icon(Icons.add),
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          CarrinhoModel.of(context).incrementarProduto(produtoCarrinho);
                        },
                      ),
                      FlatButton(
                        child: Text("Remover"),
                        textColor: Colors.grey[500],
                        onPressed: (){
                          CarrinhoModel.of(context).removeItemCarrinho(produtoCarrinho);
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      );
    }

    return Card(
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: produtoCarrinho.produto == null
            ? //caso nao tenha os dados dos produtos ira buscar no firebase
            FutureBuilder<DocumentSnapshot>(
                future: Firestore.instance
                    .collection("produtos")
                    .document(produtoCarrinho.categoria)
                    .collection("itens")
                    .document(produtoCarrinho.idProduto)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    produtoCarrinho.produto =
                        DadosProduto.fromDocument(snapshot.data);
                    return _builderContent();
                  } else {
                    return Container(
                      height: 70.0,
                      child: CircularProgressIndicator(),
                      alignment: Alignment.center,
                    );
                  }
                },
              )
            : _builderContent() //caso já possua os dados é so mostrar aqui
        );
  }
}
