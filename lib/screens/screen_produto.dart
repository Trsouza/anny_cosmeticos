import 'package:anny_cosmeticos/dados/dados_produto.dart';
import 'package:anny_cosmeticos/dados/produto_carrinho.dart';
import 'package:anny_cosmeticos/models/carrinho_model.dart';
import 'package:anny_cosmeticos/models/usuario_model.dart';
import 'package:anny_cosmeticos/screens/screen_login.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class ScreenProduto extends StatefulWidget {

  final DadosProduto produto;

  ScreenProduto(this.produto);

  @override
  _ScreenProdutoState createState() => _ScreenProdutoState(produto);
}

class _ScreenProdutoState extends State<ScreenProduto> {
  final  DadosProduto produto;
  // String tam =null;
  _ScreenProdutoState(this.produto);

  @override
  Widget build(BuildContext context) {
    final Color _primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: Text(produto.titulo),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(aspectRatio: 0.9,
            child: Carousel(
              images: produto.imagens.map((url){
                return NetworkImage(url);
              }).toList(),
              dotSize: 4.0,
              dotSpacing: 15.0,
              dotBgColor: Colors.transparent,
              dotColor: _primaryColor,
              autoplay: false, // se fosse true, as imagens ficariam se alterando sozinhas
            ), 
          ),
          Padding(padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                produto.titulo,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500
                ),
                maxLines: 3,
              ),
              Text(
                "R\$ ${produto.preco.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: _primaryColor

                ),
              ),
              Text(
                "Quantidade"
              ),
              // EditableText(

              // ),
              
              SizedBox(height: 16.0),
              SizedBox(
                height: 44.0,
                child: RaisedButton(
                  onPressed: //tam!= null ?
                    (){
                      if(UsuarioModel.of(context).usuarioLogado()){
                        ProdutoCarrinho produtoCarrinho = ProdutoCarrinho();
                        produtoCarrinho.qtd = 1;
                        produtoCarrinho.idProduto = produto.id;
                        produtoCarrinho.categoria = produto.categoria;

                        CarrinhoModel.of(context).adicionarItem(produtoCarrinho);
                        //aqui eu poderia abrir direto o carrinho, com o mesmo codigo abaixo, 
                        // ou abrir uma tela perguntando se o usuário quer ir para o carrinho

                      }else{
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=> ScreenLogin())
                        );
                      }
                    } , //: null,
                    child: Text(UsuarioModel.of(context).usuarioLogado() ?"Adicionar ao carrinho"
                    : "Entre para comprar",
                    style: TextStyle(fontSize: 18.0 ),
                  ),
                  color: _primaryColor,
                  textColor: Colors.white,
                  shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
                ),
              ),
              SizedBox(height: 16.0,),
              Text("Descrição",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500
              ),
              ),
              Text(
                produto.descricao,
              style: TextStyle(
                fontSize: 16.0,
                // fontWeight: FontWeight.w500
              ),
              ),
            ],
          ),
          )
        ],
      ),
    );
  }
}