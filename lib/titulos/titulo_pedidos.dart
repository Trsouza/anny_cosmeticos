import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TituloPedidos extends StatelessWidget {
  final String pedidoId;
  TituloPedidos(this.pedidoId);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance.collection("todos_pedidos").document(pedidoId).snapshots(),
          builder: (context, snap){
            if(!snap.hasData){
              return Center(child: CircularProgressIndicator(),);
            }else{
              int status = snap.data["status"];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                Text("Código do pedido: ${snap.data.documentID}",
                style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4.0,),
                Text(_buildProdutosTexto(snap.data)),
                SizedBox(height: 4.0,),
                
                Text("Status do pedido",
                style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                _buildCirculo("1", "Preparação", status, 1),
                Container(height: 1.0, width: 40.0, color: Colors.grey[500],),
                _buildCirculo("2", "Transporte", status, 2),
                Container(height: 1.0, width: 40.0, color: Colors.grey[500],),
                _buildCirculo("3", "Entrega", status, 3)
                ],)

              ],);
            }
          },
          ),
        ),
    );
  }
  String _buildProdutosTexto(DocumentSnapshot snap){
    String texto = "Descrição: \n";
    for(LinkedHashMap p in snap.data["produtos"]){
      texto += "${p["qtd"]} x ${p["produto"]["titulo"]} (R\$ ${p["produto"]["preco"].toStringAsFixed(2)})\n";
    }
    texto += "Total: R\$ ${snap.data["totalC"].toStringAsFixed(2)}";
    return texto;
  }

  Widget _buildCirculo(String titulo,String subTitulo, int status, int thisStatus){
    Color backColor;
    Widget child;

    if(status<thisStatus){
      backColor = Colors.grey[500];
      child = Text(titulo,style:TextStyle(color: Colors.white));
    }else if (status==thisStatus){
      backColor = Colors.blue;
      child = Stack(alignment: Alignment.center,
      children: <Widget>[
        Text(titulo,style:TextStyle(color: Colors.white)),
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        )
      ],
      );
    }else{
    backColor = Colors.green;
    child = Icon(Icons.check, color: Colors.white,);
  }
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 20.0,
          backgroundColor: backColor,
          child: child,
        ),
        Text(subTitulo)
      ],
    );
  }

}