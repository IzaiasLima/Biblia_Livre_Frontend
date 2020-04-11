import 'package:flutter/material.dart';
import 'package:freebible/pages/about_page.dart';
import 'package:freebible/pages/info_page.dart';
import 'package:freebible/utils/nav.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                  backgroundImage:
                      AssetImage("assets/images/biblia_livre.png")),
              accountName: Text("BÍBLIA LIVRE"),
              accountEmail: Text("by Izaias Lima\ne-mail: biblialivre@izaias.dev"),
            ),
            ListTile(
              leading: Icon(Icons.bookmark_border),
              title: Text("A versão Bíblia Livre"),
              subtitle: Text("Mais informações"),
              onTap: () {
                _onInfoClick(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.help_outline),
              title: Text("Sobre"),
              onTap: () {
                _onAboutClick(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  _onInfoClick(context) {
    Navigator.pop(context);
    push(context, InfoPage());
  }

  _onAboutClick(context) {
    Navigator.pop(context);
    push(context, AboutPage());
  }
}
