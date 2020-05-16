import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freebible/utils/constants.dart';

class AboutPage extends StatelessWidget {
  static const spacer = 10.0;
  static const size = fontSize - 2;

  @override
  Widget build(BuildContext context) {
    return _body(context);
  }

  Widget _body(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sobre o aplicativo"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: _content(),
        ),
      ),
    );
  }

  _content() {
    return Center(
      child: Column(
        children: <Widget>[
          _about(),
          _info(),
        ],
      ),
    );
  }

  Widget _about() {
    return Column(
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
            "Versão 1.1.3",
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
          padding: EdgeInsets.only(top: spacer, bottom: spacer),
          child: Text(
            "http://www.izaias.com.br/",
            style: TextStyle(
              fontSize: size,
            ),
          ),
        ),
      ],
    );
  }

  Widget _info() {
    return Padding(
      padding: const EdgeInsets.all(spacer),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Divider(
            color: Colors.black26,
          ),
          Container(
            padding: EdgeInsets.only(top: spacer),
            child: Text(
              "Sobre o texto usado nesta versão da bíblia",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: spacer),
            child: Text(
              "Este aplicativo usa uma versão baseada no Texto Crítico, sem as variantes, "
              "com alguns acréscimos oriundos do Texto Recebido. Essa tradução foi fornecida "
                  "pelo projeto Bíblia Livre (BLIVRE), que provê uma versão livre "
                  "do texto bíblico em Portguês do Brasil. A versão usada neste aplicativo "
                  "foi a revisão 2018.2.0, liberada em 25.02.2018.",
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: (fontSize - 6)),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: spacer),
            child: Text(
              "Copyright © Diego Santos, Mario Sérgio, e  Marco Teles",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: (fontSize - 7)),
            ),
          ),
          Container(
            child: Text(
              "http://sites.google.com/site/biblialivre/",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: (fontSize - 7)),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: spacer),
            child: Text(
              "Licença Creative Commons Atribuição 3.0 Brasil (http://creativecommons.org/licenses/by/3.0/br/)",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: (fontSize - 8)),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: spacer),
            child: Text(
              "Reprodução permitida desde que os autores e a fonte sejam devidamente mencionados.",
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: (fontSize - 8)),
            ),
          ),
        ],
      ),
    );
  }
}
