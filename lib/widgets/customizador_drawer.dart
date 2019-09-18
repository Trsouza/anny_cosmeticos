import 'package:anny_cosmeticos/models/usuario_model.dart';
import 'package:anny_cosmeticos/screens/screen_login.dart';
import 'package:anny_cosmeticos/titulos/titulos_drawer.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomizadorDrawer extends StatelessWidget {
  final PageController paginaController;

  CustomizadorDrawer(this.paginaController);

  @override
  Widget build(BuildContext context) {
    // Widget _criarDegradeDrawer() => Container(
    //       decoration: BoxDecoration(
    //           gradient: LinearGradient(
    //               colors: [Colors.purple[300], Colors.blue[50]],
    //               begin: Alignment.topCenter,
    //               end: Alignment.bottomCenter)),
    //     );

    return Drawer(
      child: Stack(
        children: <Widget>[
          // _criarDegradeDrawer(),
          // _addImagem(),

          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 16.0),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 230.0,
                child: Stack(
                  children: <Widget>[
                    // Positioned(
                    //   top: 8.0,
                    //   left: 0.0,
                    //   child: Text(
                    //     "Anny \n Cosméticos",
                    //     style: TextStyle(
                    //       fontFamily: "Sofia",
                    //       fontSize: 28.0,
                    //       color: Colors.pink[600],
                    //     ),
                    //   ),
                    // ),
                    Positioned(
                        // bottom: -40.0,
                        left: 10.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Image.asset(
                              "assets/images/anny_cosmeticos.png",
                              width: 220.0,
                            ),
                          ],
                        )),
                    Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        child: ScopedModelDescendant<UsuarioModel>(
                          builder: (context, child, model) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Olá, ${!model.usuarioLogado() ? "" : model.usuario["nome"]}",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                GestureDetector(
                                  child: Text(
                                    !model.usuarioLogado()
                                        ? "Entre ou Cadastre-se "
                                        : "Sair",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onTap: () {
                                    if (!model.usuarioLogado()) {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ScreenLogin()));
                                    } else {
                                      model.sair();
                                    }
                                  },
                                )
                              ],
                            );
                          },
                        )),
                  ],
                ),
              ),
              Divider(),
              TituloDrawer(Icons.home, "Início", paginaController, 0),
              TituloDrawer(Icons.list, "Produtos", paginaController, 1),
              TituloDrawer(Icons.location_on, "Lojas", paginaController, 2),
              TituloDrawer(Icons.playlist_add_check, "Meus Pedidos",
                  paginaController, 3),
            ],
          )
        ],
      ),
    );
  }
}
