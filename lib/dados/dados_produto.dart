import 'package:cloud_firestore/cloud_firestore.dart';

class DadosProduto{
  String id;
  String titulo;
  String descricao;
  String categoria;
  double preco;
  List imagens;
  
  DadosProduto.fromDocument(DocumentSnapshot snap){
    id = snap.documentID;
    titulo = snap.data["titulo"];
    descricao = snap.data["descricao"];
    preco = snap.data["preco"] + 0.0;
    imagens =snap.data["imagens"];
  }

  Map<String, dynamic>resumoCompra(){
    return{
      "titulo": titulo,
      "descricao": descricao,
      "preco":preco
    };
  }

}
