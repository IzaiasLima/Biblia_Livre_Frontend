import 'package:flutter/material.dart';
import 'package:freebible/models/book.dart';
import 'package:freebible/models/favorite.dart';
import 'package:freebible/models/verse.dart';
import 'package:freebible/services/favorites_bloc.dart';
import 'package:freebible/services/verse_bloc.dart';
import 'package:freebible/utils/constants.dart';
import 'package:freebible/utils/dialogs.dart';
import 'package:freebible/utils/navigator.dart';
import 'package:freebible/utils/text_utils.dart';
import 'package:freebible/widgets/custom_widgets.dart';

class ChapterPage extends StatefulWidget {
  List<Book> books;
  String verseText;
  Book book;
  int bookID;
  int chapter;
  int idxBook;

  ChapterPage(this.chapter, this.idxBook, this.books, [this.verseText = ""]);

  @override
  _ChapterPageState createState() => _ChapterPageState();
}

class _ChapterPageState extends State<ChapterPage> {
  Book book;
  VerseBloc _bloc = VerseBloc();

  _ChapterPageState();

  @override
  void initState() {
    super.initState();
    book = widget.books[widget.idxBook];
    _bloc.bookVerses(book.bookID, widget.chapter);
    _saveHistory();
  }

  _saveHistory() async {
    FavoritesBloc bloc = FavoritesBloc();
    Favorite hist = await bloc.history();
    hist.verse.bookID = book.bookID;
    hist.verse.chapter = widget.chapter;
    bloc.include(hist);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: _bloc.stream,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: Text("${book.bookName}, ${widget.chapter}"),
              actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.home),
                    onPressed: () {
                      goHome(context);
                    })
              ],
            ),
            body: _body(),
          );
        });
  }

  _body() {
    return GestureDetector(
      onHorizontalDragEnd: (details) => _onHorizontalDrag(details),
      child: StreamBuilder(
        stream: _bloc.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          if (snapshot.hasError)
            return centerText("Erro lendo a lista de versículos.");

          return _listView(snapshot.data);
        },
      ),
    );
  }

  _listView(verses) {
    return Scrollbar(
      child: ListView.builder(
        itemCount: verses.length,
        itemBuilder: (context, index) {
          return _itemView(context, verses, index);
        },
      ),
    );
  }

  _itemView(context, verses, index) {
    Verse bible = verses[index ?? 0];
    bible.bookName = book.bookName;

    FontWeight weight = (bible.verseTxt == widget.verseText)
        ? FontWeight.bold
        : FontWeight.normal;

    return InkWell(
      onLongPress: () {
        _onLongPress(bible);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
        child: Text(
          "${bible.verseID} ${cleanVerse(bible.verseTxt)}",
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: weight,
          ),
          textAlign: TextAlign.start,
        ),
      ),
    );
  }

  _onHorizontalDrag(details) {
    if (details.primaryVelocity == 0) return;

    List next = _bloc.nextChapter(
        details, widget.idxBook, widget.chapter, widget.books);
    widget.idxBook = next[0];
    widget.chapter = next[1];
    book = widget.books[widget.idxBook];
    _bloc.bookVerses(book.bookID, widget.chapter);
    PageView.builder(itemBuilder: (context, position) {
      return Container();
    });
  }

  _onLongPress(verse) {
    bottomSheetCopyFavorite(context, verse);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
