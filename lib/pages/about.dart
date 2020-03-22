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
            padding: EdgeInsets.only(top: spacer),
            child: Text(
              "Frontend da versão Bíblia Livre.",
              style: TextStyle(
                fontSize: size,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: spacer),
            child: Text(
              "by Izaias Moreira Lima",
              style: TextStyle(
                fontSize: size,
              ),
            ),
          ),
          Container(
            child: Text(
              "biblia@izaias.dev",
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
