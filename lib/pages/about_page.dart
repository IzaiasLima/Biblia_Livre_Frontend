import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freebible/utils/constants.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _body();
  }

  Widget _body() {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sobre o aplicativo"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: _content(),
      ),
    );
  }

  _content() {
    var spacer = 10.0;
    var size = fontSize - 2;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Image.asset(
              "assets/images/biblia_livre.png",
              height: 100,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: spacer),
            child: Text(
              "Bíblia Livre",
              style: TextStyle(
                fontSize: size * 1.5,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: spacer),
            child: Text(
              "Versão 1.0.9",
              style: TextStyle(
                fontSize: size - 2,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: spacer * 3),
            child: Text(
              "Izaias Moreira Lima",
              style: TextStyle(
                fontSize: size,
              ),
            ),
          ),
          Container(
            child: Text(
              "e-mail: biblia@izaias.dev",
              style: TextStyle(
                fontSize: size,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: spacer),
            child: Text(
              "http://www.izaias.dev/",
              style: TextStyle(
                fontSize: size,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: spacer),
            child: Text(
              "http://www.izaias.com.br/",
              style: TextStyle(
                fontSize: size,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
