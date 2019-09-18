import 'package:anny_cosmeticos/tabs/home_tab.dart';
import 'package:anny_cosmeticos/tabs/tab_produtos.dart';
import 'package:anny_cosmeticos/widgets/botao_carrinho.dart';
import 'package:anny_cosmeticos/widgets/customizador_drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final _paginaController = PageController();
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _paginaController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: CustomizadorDrawer(_paginaController),
          floatingActionButton: BotaoCarrinho(),
        ),
        Scaffold(appBar: AppBar(
          title: Text("Produtos"),
          centerTitle: true,

        ),
        drawer: CustomizadorDrawer(_paginaController),
        body: TabProdutos(),
        floatingActionButton: BotaoCarrinho(),
        ),
      ],
    );
  }
}
