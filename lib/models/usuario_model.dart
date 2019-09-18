import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

class UsuarioModel extends Model {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  Map<String, dynamic> usuario = Map();
  bool carregando = false;

  static UsuarioModel of(BuildContext context)=>
    ScopedModel.of<UsuarioModel>(context);

  @override
    void addListener(VoidCallback listener){
      super.addListener(listener);
      _carregarUsuario();
    }

  void cadastrar({@required Map<String, dynamic> usuario, @required String senha, @required VoidCallback onSuccess, @required VoidCallback onFail}) {
    carregando = true;
    notifyListeners();

    _auth.createUserWithEmailAndPassword(
      email: usuario["email"],
      password: senha,
      // endereco: endereco
    ).then((usuarioFirebase) async {
      firebaseUser = usuarioFirebase;
      await _salvarUsuario(usuario);

      onSuccess();
      carregando = false;
      notifyListeners();
    }).catchError((e){
      onFail();
      carregando = false;
      notifyListeners();
    });
  }

  void entrar({@required String email, @required String senha, @required VoidCallback onSuccess, @required VoidCallback onFail}) async{
    carregando = true;
    notifyListeners();

    _auth.signInWithEmailAndPassword(email: email, password: senha).then(
      (usuario) async{
        firebaseUser = usuario;

        await _carregarUsuario();
       onSuccess();
      carregando = false;
      notifyListeners();
    }).catchError((e){
      onFail();
      carregando = false;
      notifyListeners();
    });
  }

  bool usuarioLogado(){
    return firebaseUser != null;
  }

  void sair(){
    _auth.signOut();
    usuario = Map();
    firebaseUser = null;
    notifyListeners();
  }

  void recuperarSenha(String email){
    _auth.sendPasswordResetEmail(email:email);
  }

  //Para criar a lista de usuários no firebase
  Future<Null> _salvarUsuario(Map<String, dynamic> usuario) async{
    this.usuario = usuario;
    await Firestore.instance.collection("usuarios").document(firebaseUser.uid).setData(usuario);
  }

  Future<Null> _carregarUsuario()async{
    if(firebaseUser == null)
      firebaseUser = await _auth.currentUser();
    if(firebaseUser !=null){
      if(usuario["nome"] == null){
        DocumentSnapshot docUsuario = 
          await Firestore.instance.collection("usuarios").document(firebaseUser.uid).get();
          usuario = docUsuario.data;
      }
    }
    notifyListeners();
  }
}
