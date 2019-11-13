import 'package:anny_cosmeticos/telas/carrinho_tela.dart';
import 'package:flutter/material.dart';

class BotaoCarrinho extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.shopping_cart, color:Colors.white),
      onPressed: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=>CarrinhoTela())
        );
      },
      backgroundColor: Theme.of(context).primaryColor,
      
    );
  }
}