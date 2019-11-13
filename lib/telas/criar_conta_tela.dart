import 'package:anny_cosmeticos/models/usuario_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';


class CriarContaTela extends StatefulWidget {
  @override
  _CriarContaTelaState createState() => _CriarContaTelaState();
}

class _CriarContaTelaState extends State<CriarContaTela> {
  final _nomeControlador = TextEditingController();
  final _emailControlador = TextEditingController();
  final _senhaControlador = TextEditingController();
  final _enderecoControlador = TextEditingController();
  // final _cpfControlador = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Criar Conta"),
          centerTitle: true,
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
                    controller: _nomeControlador,
                    decoration: InputDecoration(hintText: "Nome"),
                    validator: (texto) {
                      if (texto.isEmpty) return "Nome inválido";
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _enderecoControlador,
                    decoration: InputDecoration(hintText: "Endereço"),
                    validator: (texto) {
                      if (texto.isEmpty) return "Endereço inválido";
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _emailControlador,
                    decoration: InputDecoration(hintText: "E-mail"),
                    keyboardType: TextInputType
                        .emailAddress, // faz aparecer o @ do teclado
                    validator: (texto) {
                     bool emailValido = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(texto);
                      if (texto.isEmpty || !emailValido)
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
                    height: 28.0,
                  ),
                  RaisedButton(
                    child: Text(
                      "Criar conta",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Map<String, dynamic> usuario = {
                          "nome": _nomeControlador.text,
                          "email": _emailControlador.text,
                          "endereco": _enderecoControlador.text,
                        };
                        model.cadastrar(
                            usuario: usuario,
                            senha: _senhaControlador.text,
                            onSuccess: _onSuccess,
                            onFail: _onFail);
                      }
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                  ),
                ],
              ),
            );
          },
        ));
  }

  void _onSuccess() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text("Usuário criado com sucesso!"),
        backgroundColor: Theme.of(context).primaryColor,
        duration: Duration(seconds: 2),
      )
    );
    Future.delayed(Duration(seconds: 2)).then((_){
      Navigator.of(context).pop();
    });
  }
  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text("Falha ao criar usuário!"),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2),
      )
    );
  }
}
