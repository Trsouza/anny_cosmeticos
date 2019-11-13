
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'models/carrinho_model.dart';
import 'models/usuario_model.dart';
import 'telas/home_tela.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UsuarioModel>(
        model:
        UsuarioModel(),
        child: ScopedModelDescendant<UsuarioModel>(
          builder: (context, child, model) {
            return ScopedModel<CarrinhoModel>(
              model: CarrinhoModel(model),
              child: MaterialApp(
                  title: 'Loja',
                  theme: ThemeData(
                    primaryColor: Colors.pink[300],
                  ),
                  debugShowCheckedModeBanner: false,
                  home: HomeTela()
              ),
            );
          },
        )
    );
  }
}
