import 'package:anny_cosmeticos/models/usuario_model.dart';
import 'package:anny_cosmeticos/screens/screen_criar_conta.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ScreenLogin extends StatefulWidget {
  @override
  _ScreenLoginState createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  final _formKey = GlobalKey<FormState>();
  final _emailControlador = TextEditingController();
  final _senhaControlador = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Entrar"),
          centerTitle: true,
          // actions: <Widget>[ // cria botão dentro do appBar
          //   FlatButton(
          //     child: Text(
          //       "Criar Conta",
          //       style: TextStyle(
          //         fontSize: 15.0,
          //       ),
          //     ),
          //     textColor: Colors.white,
          //     onPressed: () {},
          //   )
          // ],
        ),
        body: ScopedModelDescendant<UsuarioModel>(
          builder: (context, child, model) {
            if (model.carregando)
              return Center(
                child: CircularProgressIndicator(),
              );
            return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: <Widget>[
                  TextFormField(
                    controller: _emailControlador,
                    decoration: InputDecoration(hintText: "E-mail"),
                    keyboardType: TextInputType
                        .emailAddress, // faz aparecer o @ do teclado
                    validator: (texto) {
                      if (texto.isEmpty || !texto.contains("@"))
                        return "E-mail inválido";
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _senhaControlador,
                    decoration: InputDecoration(hintText: "Senha"),
                    obscureText:
                        true, //impede o usuário de ver a senh que está sendo digitada
                    validator: (texto) {
                      if (texto.isEmpty || texto.length < 6)
                        return "Senha inválida";
                    },
                  ),

                  SizedBox(
                    height: 16.0,
                  ),
                  RaisedButton(
                    child: Text(
                      "Entrar",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {}
                      model.entrar(
                          email: _emailControlador.text,
                          senha: _senhaControlador.text,
                          onSuccess: _onSuccess,
                          onFail: _onFail);
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                  ),
                  Text(
                    "ou",
                    textAlign: TextAlign.center,
                  ),
                  // SizedBox(height: 16.0,),
                  RaisedButton(
                    child: Text(
                      "Criar conta",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                          // pushReplacement - evitar eu voltar para a tela de entrar, voltarei para o drawer

                          MaterialPageRoute(
                              builder: (context) => ScreenCriarConta()));
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(40.0),
                    child: Align(
                      // esse align é pq antes eu estava alinhando o botão a direita, eu poderia remover e fazer igual os anteriores
                      alignment: Alignment.center,
                      child: FlatButton(
                        onPressed: () {
                          if (_emailControlador.text.isEmpty) {
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                              content:
                                  Text("Insira sem e-mail para recuperação!"),
                              backgroundColor: Colors.redAccent,
                              duration: Duration(seconds: 2),
                            ));
                          } else {
                              model.recuperarSenha(_emailControlador.text);
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content:
                                    Text("Confira seu email!"),
                                backgroundColor: Colors.redAccent,
                                duration: Duration(seconds: 2),
                              ));
                          }
                        },
                        child: Text(
                          "Esqueci minha senha",
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 15.0),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ));
  }

  void _onSuccess() {
    Navigator.of(context).pop();
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Falha ao entrar!"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}
