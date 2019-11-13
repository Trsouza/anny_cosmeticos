import 'package:anny_cosmeticos/models/carrinho_model.dart';
import 'package:anny_cosmeticos/models/usuario_model.dart';
import 'package:anny_cosmeticos/telas/login_tela.dart';
import 'package:anny_cosmeticos/tiles/carrinho_tile.dart';
import 'package:anny_cosmeticos/widgets/desconto_cartao.dart';
import 'package:anny_cosmeticos/widgets/frete_cartao.dart';
import 'package:anny_cosmeticos/widgets/preco_cartao.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CarrinhoTela extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meu Carrinho"),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 8.0),
            alignment: Alignment.center,
            child: ScopedModelDescendant<CarrinhoModel>(
              builder: (context, child, model) {
                int numPro = model.produtos.length;
                return Text(
                  "${numPro ?? 0} ${numPro == 1 ? "Item" : "Itens"}",
                  style: TextStyle(fontSize: 17.0),
                );
              },
            ),
          )
        ],
      ),
      body: ScopedModelDescendant<CarrinhoModel>(
        builder: (context, child, model) {
          if (model.carregando && UsuarioModel.of(context).usuarioLogado()) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (!UsuarioModel.of(context).usuarioLogado()) {
            return Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.remove_shopping_cart,
                    size: 80.0,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    "Faça o login para adicionar um produto",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  RaisedButton(
                    child: Text("Entrar", style: TextStyle(fontSize: 18.0),),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    onPressed: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context)=>LoginTela())
                      );
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    )
                ],
              ),
            );
          }else if(model.produtos == null || model.produtos.length == 0){
            return Center(
              child: Text("Nenhum produto no carrinho", 
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                ),

            );
          }else{
            return ListView(
              children: <Widget>[
                Column(
                  children: model.produtos.map( // pega cada produto e transforma em um CarrinhoTile
                    (prod){
                      return CarrinhoTile(prod);
                    }
                  ).toList(),
                ),
                CartaoDesconto(),
                CartaoFrete(),
                CartaoPreco(() async{
                  String pedidos = await model.todosPedidos();
                  if(pedidos != null)
                    print(pedidos);
                }),
              ],
            );
          }
        },
      ),
    );
  }
}
