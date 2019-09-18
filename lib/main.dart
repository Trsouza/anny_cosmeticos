import 'package:anny_cosmeticos/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'models/carrinho_model.dart';
import 'models/usuario_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UsuarioModel>(
        model:
            UsuarioModel(), // tudo que tiver a baixo do scopede model, terá acesso ao usuaioModel
        child: ScopedModelDescendant<UsuarioModel>(
          builder: (context, child, model) {
            return ScopedModel<CarrinhoModel>(
              model: CarrinhoModel(model),
              child: MaterialApp(
                  title: 'Loja', // esse titulo não aparece
                  theme: ThemeData(
                    // primarySwatch: Colors.pink,
                    //  primaryColor: Color.fromARGB(200, 128, 0, 128)),
                    primaryColor: Colors.pink[300],
                    // primaryColorDark: Color.fromRGBO(800, 128, 0, 10),
                    // primaryColorLight: Color.fromRGBO(150,122,10,20)
                  ),
                  debugShowCheckedModeBanner: false,
                  home: HomeScreen()),
            );
          },
        ));
  }
}
