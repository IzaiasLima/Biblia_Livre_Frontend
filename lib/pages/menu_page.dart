import 'package:flutter/material.dart';
import 'package:freebible/models/book.dart';
import 'package:freebible/models/favorite.dart';
import 'package:freebible/pages/about_page.dart';
import 'package:freebible/pages/chapter_page.dart';
import 'package:freebible/pages/favorites_page.dart';
import 'package:freebible/services/books_bloc.dart';
import 'package:freebible/services/favorites_bloc.dart';
import 'package:freebible/utils/constants.dart';
import 'package:freebible/utils/navigator.dart';
import 'package:share/share.dart';

import 'books_list_page.dart';

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
              dense: true,
              leading: Icon(Icons.cloud_queue),
              title: Text("Antigo Testamento"),
              onTap: (() {
                Navigator.pop(context);
                push(context, BooksListPage(Testament.AT));
              }),
            ),
            ListTile(
              dense: true,
              leading: Icon(Icons.flare),
              title: Text("Novo Testamento"),
              onTap: (() {
                Navigator.pop(context);
                push(context, BooksListPage(Testament.NT));
              }),
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text("Histórico"),
              subtitle: Text("Último capítulo acessado"),
              onTap: () => _onHistoryClick(context),
            ),
            ListTile(
              leading: Icon(Icons.favorite_border),
              title: Text("Favoritos"),
              subtitle: Text("Versículos preferidos"),
              onTap: () => _onFavoritesClick(context),
            ),
            ListTile(
              leading: Icon(Icons.language),
              title: Text("Versículos mais citados"),
              subtitle: Text("Os 200 versículos mais citados"),
              onTap: () => _onOthersFavoritesClick(context),
            ),
            Divider(
              color: Colors.black26,
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text("Compartilhe a Palavra"),
              subtitle: Text("Envie este aplicativo e abençoe outras vidas"),
              onTap: () => _onShareClick(context),
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

  _onAboutClick(context) {
    Navigator.pop(context);
    push(context, AboutPage());
  }

  _onFavoritesClick(context) {
    Navigator.pop(context);
    push(context, FavoritesPage(FavoriteType.MINE));
  }

  _onOthersFavoritesClick(BuildContext context) {
    Navigator.pop(context);
    push(context, FavoritesPage(FavoriteType.OTHERS));
  }

  _onHistoryClick(BuildContext context) {
    Navigator.pop(context);
    _showChapter(context);
  }

  _onShareClick(BuildContext context) {
    Navigator.pop(context);
    final text = "Estou usando este aplativo da bíblia, muito prático! "
        "Você deveria experimentar!\n"
        "https://play.google.com/store/apps/details?id=dev.izaias.freebible";
    final RenderBox box = context.findRenderObject();
    Share.share(
      text,
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
    );
  }

  _showChapter(context) async {
    BooksBloc booksBloc = BooksBloc();
    FavoritesBloc bloc = FavoritesBloc();

    try {
      Favorite hist = await bloc.history();
      List<Book> books = await booksBloc.book(hist.verse.bookID);
      push(context, ChapterPage(hist.verse.chapter, 0, books));
    } catch (_) {}
  }
}
