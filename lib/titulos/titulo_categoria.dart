import 'package:anny_cosmeticos/screens/screen_categoria.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TituloCategoria  extends StatelessWidget {

  final DocumentSnapshot snapshot;

  TituloCategoria(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return ListTile( // Lista onde conterá todas as categorias dos produtos
      //  leading: CircleAvatar( radius: 25.0,
      // backgroundColor: Colors.transparent,
      // backgroundImage: NetworkImage(snapshot.data["icone"]),
      // ),   // Para ícone
      title: Text(snapshot.data["titulo"]),
      trailing: Icon(Icons.keyboard_arrow_down), // ícone de seta
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=> ScreenCategoria(snapshot))
        );
      },
    );
  }
}