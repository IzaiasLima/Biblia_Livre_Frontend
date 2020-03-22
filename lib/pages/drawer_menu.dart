import 'package:flutter/material.dart';
import 'package:freebible/pages/about.dart';
import 'package:freebible/pages/info.dart';
import 'package:freebible/utils/nav.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Izaias Lima"),
              accountEmail: Text("biblia@izaias.dev"),
            ),
            ListTile(
              leading: Icon(Icons.bookmark_border),
              trailing: Icon(Icons.arrow_forward_ios),
              title: Text("A versão Bíblia Livre"),
              subtitle: Text("Mais informações"),
              onTap: () {
                _onInfoClick(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.help_outline),
              trailing: Icon(Icons.arrow_forward_ios),
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
