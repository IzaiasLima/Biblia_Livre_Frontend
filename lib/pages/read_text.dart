import 'package:flutter/material.dart';
import 'package:freebible/models/bible.dart';
import 'package:freebible/models/book.dart';
import 'package:freebible/utils/constants.dart';
import 'package:freebible/utils/db.dart';
import 'package:freebible/utils/dialogs.dart';
import 'package:freebible/utils/nav.dart';

class ReadTextPage extends StatefulWidget {
  List<Book> books;
  Book book;
  int chapter;
  int idxBook;

  ReadTextPage(this.books, this.chapter, this.idxBook);

  @override
  _ReadTextPageState createState() =>
      _ReadTextPageState(books, chapter, idxBook);
}

class _ReadTextPageState extends State<ReadTextPage> {
  Book book;
  int bookID;
  int chapter;
  int idxBook;

  final List<Book> books;
  var chapterText;

  _ReadTextPageState(this.books, this.chapter, this.idxBook);

  @override
  void initState() {
    book = books[idxBook];
    chapterText = _getChapterText(bookID, chapter);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bookID = book.bookID;

    return Scaffold(
      appBar: AppBar(
        title: Text("${book.bookName}, $chapter"),
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
  }

  _body() {
    List<dynamic> verses;
    return GestureDetector(
      onHorizontalDragEnd: (details) => _onHorizontalDrag(details),
      child: FutureBuilder(
        future: _getChapterText(bookID, chapter),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            verses = snapshot.data;
            return _listView(verses);
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
    return ListView.builder(
      itemCount: verses.length,
      itemBuilder: (context, index) {
        return _itemView(context, verses, index);
      },
    );
  }

  _itemView(context, verses, index) {
    Bible bible = verses[index] ?? 0;
    var verseID = bible.verseID;
    var verseTxt = bible.verseTxt;

    return GestureDetector(
      onTap: () => Scaffold.of(context).hideCurrentSnackBar(),
      onLongPress: () {
        _onLongPress(context, book.bookName, chapter, verseID, verseTxt);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
        child: Text(
          "$verseID $verseTxt",
          style: TextStyle(fontSize: fontSize),
          textAlign: TextAlign.start,
        ),
      ),
    );
  }

  _getChapterText(bookID, chapter) {
    if (bookID == null) return null;
    DBProvider db = DBProvider.provider;
    return db.allVerses(bookID, chapter);
  }

  _onHorizontalDrag(details) {
    if (details.primaryVelocity == 0) return;

    if (details.primaryVelocity.compareTo(0) == -1) {
      if (++chapter > book.chapters) {
        if (idxBook < books.length - 1) {
          chapter = 1;
          book = books[++idxBook];
        } else {
          chapter = book.chapters;
        }
      }
    } else {
      if (--chapter < 1) {
        if (idxBook > 0) {
          book = books[--idxBook];
          chapter = book.chapters;
        } else {
          chapter = 1;
        }
      }
    }
    bookID = book.bookID;
    setState(() => _body());
  }

  _onLongPress(context, bookName, chapter, verseID, String verseTxt) {
    var ref = "$bookName, $chapter:$verseID";
    copyToClipboard(context, ref, verseTxt);
  }
}
