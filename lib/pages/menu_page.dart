import 'package:flutter/material.dart';
import 'package:freebible/pages/about_page.dart';
import 'package:freebible/pages/favorites_page.dart';
import 'package:freebible/pages/info_page.dart';
import 'package:freebible/utils/constants.dart';
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
                  backgroundColor: primary,
                  backgroundImage:
                      AssetImage("assets/images/biblia_livre.png")),
              accountName: Text("BÍBLIA LIVRE"),
              accountEmail: Text("biblia@izaias.dev"),
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text("Histórico"),
              subtitle: Text("Textos lidos anteriormente"),
            ),
            ListTile(
              leading: Icon(Icons.favorite_border),
              title: Text("Favoritos"),
              subtitle: Text("Versículos preferidos"),
              onTap: () => _onFavoritesClick(context),
            ),
            ListTile(
              leading: Icon(Icons.language),
              title: Text("Mais conhecidos"),
              subtitle: Text("Seleção dos versos mais lidos"),
            ),
            Divider(
              color: Colors.black26,
            ),
            ListTile(
              leading: Icon(Icons.bookmark_border),
              title: Text("Sobre o texto usado nesta Bíblia"),
              subtitle: Text("Mais informações"),
              onTap: () => _onInfoClick(context),
            ),
            ListTile(
              leading: Icon(Icons.help_outline),
              title: Text("Sobre o aplicativo"),
              onTap: () => _onAboutClick(context),
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

  _onFavoritesClick(context) {
    Navigator.pop(context);
    push(context, FavoritesPage());
  }
}
