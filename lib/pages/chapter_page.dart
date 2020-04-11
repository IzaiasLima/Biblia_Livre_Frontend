import 'package:flutter/material.dart';
import 'package:freebible/models/bible.dart';
import 'package:freebible/models/book.dart';
import 'package:freebible/services/bible_bloc.dart';
import 'package:freebible/utils/constants.dart';
import 'package:freebible/utils/dialogs.dart';
import 'package:freebible/utils/nav.dart';
import 'package:freebible/utils/text_utils.dart';

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
  BibleBloc _bloc = BibleBloc();

  _ChapterPageState();

  @override
  void initState() {
    super.initState();
    book = widget.books[widget.idxBook];
    _bloc.bookVerses(book.bookID, widget.chapter);
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
    List<dynamic> verses;

    return GestureDetector(
      onHorizontalDragEnd: (details) => _onHorizontalDrag(details),
      child: StreamBuilder(
        stream: _bloc.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            verses = snapshot.data;
            return _listView(verses);
          } else if (snapshot.hasError) {
            return centerText("Erro lendo a lista de versículos.");
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
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
    Bible bible = verses[index] ?? 0;
    String verseTxt = cleanVerse(bible.verseTxt);

    FontWeight weight =
        (bible.verseTxt == widget.verseText) ? FontWeight.bold : FontWeight.normal;

    return GestureDetector(
      onTap: () => Scaffold.of(context).hideCurrentSnackBar(),
      onLongPress: () {
        _onLongPress(context, book.bookName, widget.chapter, bible.verseID,
            bible.verseTxt);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
        child: Text(
          "${bible.verseID} $verseTxt",
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
  }

  _onLongPress(context, bookName, chapter, verseID, String verseTxt) {
    var ref = "$bookName, $chapter:$verseID";
    copyToClipboard(context, ref, verseTxt);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
