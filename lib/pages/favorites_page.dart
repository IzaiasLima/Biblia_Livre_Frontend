import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:freebible/models/bible.dart';
import 'package:freebible/models/book.dart';
import 'package:freebible/pages/chapter_page.dart';
import 'package:freebible/services/books_bloc.dart';
import 'package:freebible/services/favorites_bloc.dart';
import 'package:freebible/utils/constants.dart';
import 'package:freebible/utils/dialogs.dart';
import 'package:freebible/utils/nav.dart';
import 'package:freebible/utils/text_utils.dart';
import 'package:styled_text/styled_text.dart';

class FavoritesPage extends StatefulWidget {
  FavoritesPage();

  @override
  _FavoritesPageState createState() => new _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  BooksBloc _booksBloc = BooksBloc();
  FavoritesBloc _favBloc = FavoritesBloc();
  bool _isCopying = false;

  @override
  void initState() {
    super.initState();
    _favBloc.favorites(FavoriteType.MINE);
  }

  @override
  Widget build(BuildContext context) {
    String title = "Meus Favoritos";
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: accent,
        title: Text(title),
      ),
      body: _body(),
    );
  }

  _body() {
    List<Bible> verses;
    return StreamBuilder(
        stream: _favBloc.stream,
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return centerText("Erro lendo a lista de favoritos. \n ${snapshot.error}" );

          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          verses = snapshot.data;
          print(verses);
          return _listView(verses);

        });
  }

  _listView(verses) {
    return Scrollbar(
      child: ListView.builder(
        key: _listKey,
        itemCount: verses.length,
        itemBuilder: (context, index) {
          return _itemView(context, verses, index);
        },
      ),
    );
  }

  _itemView(context, verses, index) {
    Bible bible = verses[index];

    var ref = "${bible.bookName} ${bible.chapter}:${bible.verseID}";
    var verse = bible.verseTxt;
    var size = fontSize - 2;

    return ListTile(
      contentPadding: EdgeInsets.only(left: 16, right: 12),
      title: StyledText(
        text: "<bold>$ref</bold>",
        styles: {
          'bold': TextStyle(
            color: Colors.black,
            fontSize: size,
            fontWeight: FontWeight.bold,
          ),
        },
      ),
      subtitle: StyledText(
        text: "<normal>$verse</normal>",
        styles: {
          'normal': TextStyle(
            color: Colors.black,
            fontSize: size,
            fontWeight: FontWeight.normal,
          ),
        },
      ),
      onLongPress: (() {
        _isCopying = true;
        copyToClipboard(context, ref, verse);
      }),
      onTap: (() {
        if (_isCopying) {
          Scaffold.of(context).hideCurrentSnackBar();
          _isCopying = false;
        } else {
          _showChapter(bible.bookID, bible.chapter, bible.verseTxt);
        }
      }),
    );
  }

  _showChapter(bookID, chapter, verseTxt) async {
    try {
      List<Book> books = await _booksBloc.book(bookID);
      push(
        context,
        ChapterPage(chapter, 0, books, verseTxt),
      );
    } catch (e) {
      return centerText("Erro ao exibir o capítulo.");
    }
  }

  @override
  void dispose() {
    _booksBloc.dispose();
    _favBloc.dispose();
    super.dispose();
  }
}
