import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Widget _criarDegrade() => Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors:[
          
          Colors.pink[400], 
          Colors.pink[100]
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight
        )
      ),
    );
    return Stack(
      children: <Widget>[
        _criarDegrade(),
        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text("Novidades"),
                centerTitle: true,
              ),
            ),
            FutureBuilder<QuerySnapshot>(
              future: Firestore.instance.collection("home").orderBy("posi").
              getDocuments(),
              builder: (context,snapshot){
                if(!snapshot.hasData)
                  return SliverToBoxAdapter(
                    child: Container(
                      height: 200.0,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  );
                else 
                return SliverStaggeredGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 1.0,
                  crossAxisSpacing: 1.0,
                  //para documento da lista chama essa função, e essa função retorna um novo objeto q eu  quero colocar na lista
                  staggeredTiles: snapshot.data.documents.map((doc){
                    return StaggeredTile.count(doc.data["x"], doc.data["y"]);
                  },
                  ).toList(),
                  children: snapshot.data.documents.map((doc){
                    return FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: doc.data["imagem"],
                      fit: BoxFit.cover,
                    );
                  },
                  ).toList(),
                );
              },
            )
          ],
        )
      ],
    );
  }
}
