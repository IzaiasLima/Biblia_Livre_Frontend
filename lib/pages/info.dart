import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freebible/utils/constants.dart';

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _body();
  }

  Widget _body() {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sobre a Bíblia Livre"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: _content(),
      ),
    );
  }

  _content() {
    var spacer = 10.0;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(top: spacer),
          child: Text(
            "Este aplicativo usa a versão do 'Texto Crítico', sem as variantes, "
            "e com alguns acréscimos vindos do 'Texto Recebido'. O texto base "
            "usado neste aplicativo foi obtido do projeto de tradução de uma "
            "versão livre da bíblia para o Portguês do Brasil denominado "
            "Bíblia Livre (BLIVRE), revisão 2018.2.0, liberado em 25.02.2018.",
            style: TextStyle(
              fontSize: (fontSize - 6),
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(top: spacer),
          child: Text(
            "Copyright © Diego Santos, Mario Sérgio, e  Marco Teles",
            style: TextStyle(
              fontSize: (fontSize - 6),
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            "http://sites.google.com/site/biblialivre/",
            style: TextStyle(
              fontSize: (fontSize - 6),
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(top: spacer),
          child: Text(
            "Licença Creative Commons Atribuição 3.0 Brasil (http://creativecommons.org/licenses/by/3.0/br/)",
            style: TextStyle(
              fontSize: (fontSize - 8),
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(top: spacer),
          child: Text(
            "Reprodução permitida desde que os autores e a fonte sejam devidamente mencionados.",
            style: TextStyle(
              fontSize: (fontSize - 8),
            ),
          ),
        ),
      ],
    );
  }
}
