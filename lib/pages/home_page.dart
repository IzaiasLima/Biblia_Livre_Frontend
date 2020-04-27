import 'package:flutter/material.dart';
import 'package:freebible/models/verse.dart';
import 'package:freebible/pages/books_list_page.dart';
import 'package:freebible/pages/menu_page.dart';
import 'package:freebible/services/favorites_bloc.dart';
import 'package:freebible/utils/constants.dart';
import 'package:freebible/utils/navigator.dart';
import 'package:freebible/utils/text_utils.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primary,
        title: Text(appTitle),
      ),
      drawer: DrawerMenu(),
      body: Stack(alignment: Alignment.bottomRight, children: [
        _header(),
        _banner(),
        _buttonBar(context),
      ]),
    );
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
    FavoritesBloc bloc = FavoritesBloc();
    String bannerMsg;

    return FutureBuilder(
        future: bloc.randomVerse(),
        builder: (context, snapshot){

          if(snapshot.hasError)
            bannerMsg =
              "Lâmpada para os meus pés é a Tua Palavra e luz para o meu caminho.";

          if(!snapshot.hasData)
          return Center(child: CircularProgressIndicator());

          Verse verse = snapshot.data;
          bannerMsg = dotAtEnd(verse.verseTxt);

          return InkWell(
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 10, bottom: 80),
              height: 480,
              width: double.infinity,
              child: Center(
                child: Text(
                  bannerMsg,
                  style: TextStyle(
                      color: accent, fontSize: fontSize, fontStyle: FontStyle.italic),
                ),
              ),
              decoration: BoxDecoration(
                color: background,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.elliptical(98, 100),
                ),
              ),
            ),
            onTap: () => goChapter(context, verse),
          );

        },
      );
  }

  _buttonBar(context) {
    var iconSize = 35.0;
    return Container(
      color: background,
      child: Container(
        padding: EdgeInsets.all(16),
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FlatButton(
              onPressed: () {
                push(context, BooksListPage(Testament.AT));
              },
              child: Icon(
                Icons.cloud_queue,
                color: background,
                size: iconSize,
              ),
            ),
            FlatButton(
              onPressed: () {
                push(context, BooksListPage(Testament.NT));
              },
              child: Icon(
                Icons.flare,
                color: background,
                size: iconSize,
              ),
            ),
            FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: () {
                push(context, BooksListPage(Testament.ALL));
              },
              child: Icon(
                Icons.sort_by_alpha,
                color: background,
                size: iconSize,
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: accent,
          borderRadius: BorderRadius.only(
            topLeft: Radius.elliptical(30, 30),
            //bottomLeft: Radius.circular(5),
            bottomRight: Radius.elliptical(25, 25),
            // topRight: Radius.circular(5),
          ),
        ),
      ),
    );
  }
}
