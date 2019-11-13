import 'package:anny_cosmeticos/tiles/categoria_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProdutosAba extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance.collection("produtos").getDocuments(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );
        else {
          var dividirTitulos = ListTile.divideTiles(
            tiles: snapshot.data.documents.map((doc) {
              return CategoriaTile(doc);
            }).toList(),
            color: Colors.grey[500],
          ).toList();
          return ListView(
            children: dividirTitulos,
          );
        }
      },
    );
  }
}
