import 'package:anny_cosmeticos/abas/home_aba.dart';
import 'package:anny_cosmeticos/abas/pedidos_aba.dart';
import 'package:anny_cosmeticos/abas/produtos_aba.dart';
import 'package:anny_cosmeticos/widgets/botao_carrinho.dart';
import 'package:anny_cosmeticos/widgets/customizador_drawer.dart';
import 'package:flutter/material.dart';

class HomeTela extends StatelessWidget {
  final _paginaController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _paginaController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: HomeAba(),
          drawer: CustomizadorDrawer(_paginaController),
          floatingActionButton: BotaoCarrinho(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Produtos"),
            centerTitle: true,
          ),
          drawer: CustomizadorDrawer(_paginaController),
          body: ProdutosAba(),
          floatingActionButton: BotaoCarrinho(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Meus Pedidos"),
            centerTitle: true,
          ),
          body: PedidosAba(),
          drawer: CustomizadorDrawer(_paginaController),
        ),
      ],
    );
  }
}
