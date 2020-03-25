import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:freebible/models/bible.dart';
import 'package:freebible/models/book.dart';
import 'package:freebible/utils/constants.dart';
import 'package:freebible/utils/db.dart';
import 'package:freebible/utils/nav.dart';

class ReadTextPage extends StatefulWidget {
  final List<Book> books;
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
    List<Bible> verses;
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
        _onLongPress(context, book.bookName, verseID, verseTxt);
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
      ++chapter;
      if (chapter > book.chapters) {
        book = books[++idxBook];
        bookID = book.bookID;
        chapter = 1;
      }
    } else {
      --chapter;
      if (chapter <= 0) {
        book = books[--idxBook];
        bookID = book.bookID;
        chapter = book.chapters;
      }
    }

    setState(() => _body());
  }

  _onLongPress(context, bookName, verseID, String verseTxt) {
    var txt = ((verseTxt.length) > 25) ? "${verseTxt.substring(0, 25)}..." : verseTxt;
    var ref = "${book.bookName}, $chapter:$verseID";

    Scaffold.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 5),
        backgroundColor: accent,
        content: Text("$txt\n$ref"),
        action: SnackBarAction(
          label: "COPIAR",
          textColor: Colors.white,
          onPressed: () {
            Clipboard.setData(ClipboardData(text: txt));
          },
        ),
      ),
    );
  }
}
