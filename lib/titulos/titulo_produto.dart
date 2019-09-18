import 'package:anny_cosmeticos/dados/dados_produto.dart';
import 'package:anny_cosmeticos/screens/screen_produto.dart';
import 'package:flutter/material.dart';

class TituloProduto extends StatelessWidget {

  final String tipo;
  final DadosProduto produto;

  TituloProduto(this.tipo, this.produto);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ScreenProduto(produto))
        );
      },
      child: Card( // se ipo for igual a grid, colocamos uma coluna, caso contrario uma linha
        child: tipo == "grid" ?
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 0.8,
                child: Image.network(
                  produto.imagens[0],
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        produto.titulo,
                        style: TextStyle(
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      Text(
                        "R\$ ${produto.preco.toStringAsFixed(2)}",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),)
            ],
          ) 
          : Row(
            children: <Widget>[

              Flexible(
                flex: 1,
                child: Image.network(
                  produto.imagens[0],
                  fit: BoxFit.cover,
                  height: 250.0,
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        produto.titulo,
                        style: TextStyle(
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      Text(
                        "R\$ ${produto.preco.toStringAsFixed(2)}",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          )
      ,),
    );
  }
}