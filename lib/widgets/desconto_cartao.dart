import 'package:anny_cosmeticos/models/carrinho_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CartaoDesconto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ExpansionTile(
        title: Text("Cupom de Desconto",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey[700]
          ),
        ),
        leading: Icon(Icons.card_giftcard),
        trailing: Icon(Icons.add),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Digite seu cupom"
              ),
              initialValue: CarrinhoModel.of(context).cupomDesconto ?? "",
              onFieldSubmitted: (text){
                Firestore.instance.collection("cupons").document(text).get().then(
                  (docSnap){
                    if(docSnap.data != null){
                      CarrinhoModel.of(context).setarCupom(text, docSnap.data["porcentagem"]);
                      Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("Desconto de ${docSnap.data["porcentagem"]}% aplicado"),
                        backgroundColor: Theme.of(context).primaryColor)
                      );
                    }else{
                      CarrinhoModel.of(context).setarCupom(null, 0);
                       Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("Cupom inexistente"),
                        backgroundColor: Colors.redAccent)
                       );
                    }
                  }
                );
              },
            ),
          )
        ],
      ),
    );
  }
}