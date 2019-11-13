import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final IconData icone;
  final String texto;
  final PageController controller;
  final int pagina;

  DrawerTile(this.icone, this.texto, this.controller, this.pagina);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
          controller.jumpToPage(pagina); // informa a página que foi selecionada
        },
        child: Container(
          height: 45.0,
          child: Row(
            children: <Widget>[
              Icon(icone,
                  size: 32.0,
                  color: controller.page.round() == pagina
                      ? Theme.of(context).primaryColor
                      : Colors.grey[700]),
              SizedBox(
                width: 22.0,
              ),
              Text(
                texto,
                style: TextStyle(
                    fontSize: 16.0,
                    color: controller.page.round() == pagina
                        ? Theme.of(context).primaryColor
                        : Colors.grey[700]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
