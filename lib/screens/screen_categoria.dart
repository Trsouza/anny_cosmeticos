import 'package:anny_cosmeticos/dados/dados_produto.dart';
import 'package:anny_cosmeticos/titulos/titulo_produto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ScreenCategoria extends StatelessWidget {
  final DocumentSnapshot snap;

  ScreenCategoria(this.snap);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text(snap.data["titulo"]),
            centerTitle: true,
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.grid_on),
                ),
                Tab(
                  icon: Icon(Icons.list),
                ),
              ],
            ),
          ),
          body: FutureBuilder<QuerySnapshot>(
            future: Firestore.instance.collection("produtos").document(snap.documentID)
            .collection("itens").getDocuments(),
            builder: (context, snapshot) {
            if (!snapshot.hasData) //se a lista for vazia retorna um circular
              return Center(
                child: CircularProgressIndicator(),
              );
            else
              return TabBarView(
                physics:
                    NeverScrollableScrollPhysics(), //impede o usuario de arrastar de um lado para o outro a tab
                children: [
                  GridView.builder( // Grade dos produtos
                    padding: EdgeInsets.all(4.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 4.0,
                      crossAxisSpacing: 4.0,
                      childAspectRatio: 0.65
                      ),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index){
                        DadosProduto dadosProduto = DadosProduto.fromDocument(snapshot.data.documents[index]);
                        dadosProduto.categoria = this.snap.documentID;
                        return TituloProduto("grid", dadosProduto);
                      }
                  ),
                  ListView.builder(
                    padding: EdgeInsets.all(4.0),
                    itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index){
                        DadosProduto dadosProduto = DadosProduto.fromDocument(snapshot.data.documents[index]);
                        dadosProduto.categoria = this.snap.documentID;
                        return TituloProduto("list", dadosProduto);
                      }
                  )
                ]            
              );
          })),
    );
  }
}
