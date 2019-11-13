import 'package:anny_cosmeticos/models/carrinho_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CartaoPreco extends StatelessWidget {
  VoidCallback comprar;

  CartaoPreco(this.comprar);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Container(
       padding: EdgeInsets.all(16.0),
       child: ScopedModelDescendant<CarrinhoModel>(
         builder: (context, child, model){
           double preco = model.getPrecosProdutos();
           double desconto = model.getDesconto();
           double frete = model.getFrete();
           return Column(
             crossAxisAlignment: CrossAxisAlignment.stretch,
             children: <Widget>[
               Text("Resumo do Pedido", 
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.w500),
               ),
               SizedBox(height: 12.0,),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: <Widget>[
                    Text("Subtotal"),
                    Text("R\$ ${preco.toStringAsFixed(2)}"),
                 ],
               ),
               Divider(),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: <Widget>[
                    Text("Desconto"),
                    Text("R\$ - ${desconto.toStringAsFixed(2)}"),
                 ],
               ),
               Divider(),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: <Widget>[
                    Text("Entrega"),
                    Text("R\$ ${frete.toStringAsFixed(2)}"),
                 ],
               ),
               Divider(),
               SizedBox(height: 12.0,),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: <Widget>[
                    Text("Total", style: TextStyle( fontWeight: FontWeight.w500),),
                    Text("R\$ ${(preco + frete - desconto).toStringAsFixed(2)}", style: TextStyle(color: Theme.of(context).primaryColor,),),
                 ],
               ),
               Divider(),
               RaisedButton(
                    child: Text(
                      "Finalizar Compra",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    onPressed: comprar,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                  ),
             ],
           );
         },
       )

      ),
    );
  }
}