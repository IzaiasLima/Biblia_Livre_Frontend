import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:freebible/models/book.dart';
import 'package:freebible/models/favorite.dart';
import 'package:freebible/models/verse.dart';
import 'package:freebible/services/books_bloc.dart';
import 'package:freebible/services/favorites_bloc.dart';
import 'package:freebible/utils/constants.dart';
import 'package:freebible/utils/dialogs.dart';
import 'package:freebible/utils/navigator.dart';
import 'package:freebible/widgets/custom_widgets.dart';
import 'package:styled_text/styled_text.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => new _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  BooksBloc _booksBloc = BooksBloc();
  FavoritesBloc _favBloc = FavoritesBloc();
  Book book;
  List<int> chaptersList;

  final type = FavoriteType.HISTORY;

  @override
  void initState() {
    super.initState();
    _favBloc.favorites(type.index);
  }

  @override
  Widget build(BuildContext context) {
    String title = "Histórico";

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
    return StreamBuilder(
      stream: _favBloc.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());

        if (snapshot.hasError)
          return centerText("Erro ao buscar o histórico.");

        return RefreshIndicator(
          child: _listView(snapshot.data),
          onRefresh: () => _onRefreshIndicator(),
        );
      },
    );
  }

  _listView(verses) {
    return Scrollbar(
      child: ListView.builder(
        itemCount: (verses != null) ? verses.length : 0,
        itemBuilder: (context, index) {
          return _itemView(context, verses, index);
        },
      ),
    );
  }

  _itemView(context, verses, index) {
    Favorite favorite = verses[index];
    Verse verse = favorite.verse;

    var size = fontSize - 2;

    return ListTile(
      contentPadding: EdgeInsets.only(top: 6, left: 16, right: 12),
      title: StyledText(
        text: "<bold>${verse.bookName}</bold>",
        styles: {
          'bold': TextStyle(
            color: Colors.black,
            fontSize: size,
            fontWeight: FontWeight.bold,
          ),
        },
      ),
      subtitle: StyledText(
        text: "<normal>"
            "1, 2, 3, 4, 5, 6, 7, 8, 9 , 10,"
            "11, 12, 13, 14, 15, 16, 17, 18, 19 , 20,"
            "21, 22, 23, 24, 25, 26, 27, 28"
            "</normal>", // TODO
        styles: {
          'normal': TextStyle(
            color: Colors.black,
            fontSize: size,
            fontWeight: FontWeight.normal,
          ),
        },
      ),
      onLongPress: () => _onLongPress(favorite),
      onTap: () => goChapter(context, verse),
    );
  }

  _onLongPress(favorite) {
    bottomSheetCopyRemove(context, _favBloc, favorite);
  }

  _onRefreshIndicator() {
    return _favBloc.favorites(type.index);
  }

  _historyList() {
    chaptersList = _getChaptersList(book.chapters);
    return GridView.builder(
        itemCount: book.chapters,
        padding: EdgeInsets.all(16),
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
        itemBuilder: (context, index) {
          return _historyItem(context, index);
        });
  }

  _historyItem(context, index) {
    int chapter =
        ((book == null) || (chaptersList == null)) ? 0 : chaptersList[index];

    return InkWell(
      child: Container(
        padding: EdgeInsets.only(left: 0, right: 16),
        child: Text(
          "$chapter",
          style: TextStyle(fontSize: fontSize),
          textAlign: TextAlign.end,
        ),
      ),
      onTap: () {
        //push(context, ChapterPage(chapter, idxBook, books));
      },
    );
  }

  _getChaptersList(int maxChapter) {
    List<int> list = [];

    for (int chapter = 0; chapter < maxChapter; chapter++) {
      list.add(chapter + 1);
    }
    return list;
  }

  @override
  void dispose() {
    _booksBloc.dispose();
    _favBloc.dispose();
    super.dispose();
  }
}
