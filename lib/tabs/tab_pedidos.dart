import 'package:anny_cosmeticos/screens/screen_login.dart';
import 'package:anny_cosmeticos/titulos/titulo_categoria.dart';
import 'package:anny_cosmeticos/titulos/titulo_pedidos.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:anny_cosmeticos/models/usuario_model.dart';
class TabPedidos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   if(UsuarioModel.of(context).usuarioLogado()){
     String id = UsuarioModel.of(context).firebaseUser.uid;

     return FutureBuilder<QuerySnapshot>(
       future: Firestore.instance.collection("usuarios").document(id).
        collection("todos_pedidos").getDocuments(),
        builder: (context, snap){
          if(!snap.hasData){return  Center(
            child: CircularProgressIndicator(),
          );}else{
            return ListView(
              children: snap.data.documents.map((doc) => TituloPedidos(doc.documentID)
              ).toList() ,
            );
          }

        },
     );
   }else{
      return Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.view_list,
                    size: 80.0,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    "Faça o login para acompanhar o pedido",
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
                        MaterialPageRoute(builder: (context)=>ScreenLogin())
                      );
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    )
                ],
              ),
            );
   }
  }
}
