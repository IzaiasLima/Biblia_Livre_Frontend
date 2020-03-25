import 'package:flutter/material.dart';

search(context) {
  showDialog(
    context: context,
    barrierDismissible: false, // bloquear clique fora
    builder: (context) {
      // envolver o Alert dentro de WillPopScope
      // 'onWillPop: () async => false, child: AlertDialog
      // para bloquear a a tecla para trás do celular
      return AlertDialog(
        title: Text("Diálogo com mensagem de alerta."),
        actions: <Widget>[
          FlatButton(
              child: Text("CANCELAR"),
              onPressed: () {
                Navigator.pop(context);
              }),
          FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
                print("OK !!!");
              }),
        ],
      );
    },
  );
}
