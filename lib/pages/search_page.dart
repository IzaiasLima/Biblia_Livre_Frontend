import 'dart:ui';

import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:freebible/models/book.dart';
import 'package:freebible/models/verse.dart';
import 'package:freebible/pages/chapter_page.dart';
import 'package:freebible/services/books_bloc.dart';
import 'package:freebible/services/verse_bloc.dart';
import 'package:freebible/utils/constants.dart';
import 'package:freebible/utils/dialogs.dart';
import 'package:freebible/utils/navigator.dart';
import 'package:freebible/utils/widgets.dart';

class SearchPage extends StatefulWidget {
  final Testament testament;

  SearchPage([this.testament]);

  @override
  _SearchPageState createState() => new _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = new TextEditingController();

  VerseBloc _bloc = VerseBloc();
  BooksBloc _booksBloc = BooksBloc();
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    String title = "Pesquisar";
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: accent,
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.home, color: inverse),
            onPressed: () => goHome(context),
          )
        ],
      ),
      body: _body(),
    );
  }

  _body() {
    return Column(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: _inputSearch(),
        ),
        Flexible(
          flex: 4,
          fit: FlexFit.tight,
          child: _showVerses(),
        )
      ],
    );
  }

  _inputSearch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            height: 40,
            child: TextField(
              controller: _controller,
              autofocus: true,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: primary,
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.search,
            color: primary,
            size: 26,
          ),
          onPressed: () {
            _isSearching = true;
            _bloc.versesByWord(_controller.text);
          },
        )
      ],
    );
  }

  _showVerses() {
    List<Verse> verses;
    return StreamBuilder(
        stream: _bloc.stream,
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return centerText("Erro lendo a lista de versículos.");

          if (!snapshot.hasData && _isSearching)
            return Center(child: CircularProgressIndicator());

          verses = snapshot.data;

          if (verses == null)
            return centerText(
              "Informe a palavra a ser pesquisada.",
              color: Colors.black,
            );

          if (verses.length == 0) return centerText("Palavra não encontrada!");

          return _listView(verses);
        });
  }

  _listView(verses) {
    return Scrollbar(
      child: ListView.builder(
        itemCount: verses.length,
        itemBuilder: (context, index) => _itemView(context, verses, index),
      ),
    );
  }

  _itemView(context, verses, index) {
    Verse verse = verses[index];
    String search = _controller.text;

    double size = fontSize - 2;
    EasyRichText verseTagged = richText(verse.verseTxt, search, size);

    return ListTile(
      contentPadding: EdgeInsets.only(left: 16, right: 12),
      title: Text(
        verse.reference(),
        style: TextStyle(
          fontSize: size,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: verseTagged,
      onLongPress: (() {
        bottomSheetCopyFavorite(context, verse);
      }),
      onTap: (() {
        _showChapter(verse);
      }),
    );
  }

  _showChapter(Verse verse) async {
    try {
      List<Book> books = await _booksBloc.book(verse.bookID);
      push(
        context,
        ChapterPage(verse.chapter, 0, books, verse.verseTxt),
      );
    } catch (e) {
      return centerText("Erro ao exibir o capítulo.");
    }
  }

  @override
  void dispose() {
    _bloc.dispose();
    _booksBloc.dispose();
    super.dispose();
  }
}
