import 'package:flutter/material.dart';

import 'package:freebible/pages/alpha_order.dart';
import 'package:freebible/pages/drawer_menu.dart';
import 'package:freebible/pages/new_testament.dart';
import 'package:freebible/pages/old_testament.dart';
import 'package:freebible/utils/nav.dart';
import 'package:freebible/utils/constants.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return _body(context);
  }

  _body(context) {
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primary,
        title: Text(appTitle),
      ),
      drawer: DrawerMenu(),
      body: _components(context),
    );
  }

  _components(context) {
    return Stack(
        //fit: StackFit.expand,
        alignment: Alignment.bottomRight,
        children: [
          _header(),
          _banner(),
          _buttonBar(context),
        ]);
  }

  _header() {
    return Container(
      padding: EdgeInsets.only(top: 10, right: 10),
      alignment: Alignment.topRight,
      width: double.infinity,
      child: Icon(
        Icons.local_library,
        color: background,
        size: 80,
      ),
    );
  }

  _banner() {
    String bannerMsg =
        "Lâmpada para os meus pés é a Tua Palavra e luz para o meu caminho.";

    return Stack(alignment: Alignment.bottomRight, children: <Widget>[
      Container(
        padding: EdgeInsets.symmetric(vertical: 120, horizontal: 40),
        height: 400,
        width: double.infinity,
        child: Text(
          bannerMsg,
          style: TextStyle(
              color: accent, fontSize: fontSize, fontStyle: FontStyle.italic),
        ),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.only(
            topLeft: Radius.elliptical(98, 100),
          ),
        ),
      ),
    ]);
  }

  _buttonBar(context) {
    return Container(
      color: background,
      padding: EdgeInsets.all(6),
      child: Container(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FlatButton(
              onPressed: () {
                print("OLD");
                push(context, OldTestamentPage());
              },
              child: Icon(
                Icons.library_books,
                color: background,
                size: 40,
              ),
            ),
            FlatButton(
              onPressed: () {
                print("NEW");
                push(context, NewTestamentPage());
              },
              child: Icon(
                Icons.wb_sunny,
                color: background,
                size: 40,
              ),
            ),
            FlatButton(
              onPressed: () {
                print("ALFA");
                push(context, AlphaOrderPage());
              },
              child: Icon(
                Icons.sort_by_alpha,
                color: background,
                size: 40,
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
          color: accent,
          borderRadius: BorderRadius.only(
            topLeft: Radius.elliptical(90, 100),
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.elliptical(90, 100),
            topRight: Radius.circular(5),
          ),
        ),
      ),
    );
  }
}
