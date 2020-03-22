import 'package:flutter/material.dart';
import 'package:freebible/models/bible.dart';
import 'package:freebible/models/book.dart';
import 'package:freebible/utils/constants.dart';
import 'package:freebible/utils/db.dart';

class ReadTextPage extends StatelessWidget {
  Book book;
  int chapter;
  int bookID;

  ReadTextPage(this.book, this.chapter);

  @override
  Widget build(BuildContext context) {
    bookID = book.bookID;
    return Scaffold(
      appBar: AppBar(
        title: Text("${book.bookName}, ${chapter}"),
      ),
      body: _body(),
    );
  }

  _body() {
    return new FutureBuilder(
        future: _getChapter(bookID, chapter),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          List<Bible> verses = snapshot.data;
          return snapshot.hasData
              ? _listView(verses)
              : new Center(child: new CircularProgressIndicator());
        });
  }

  _listView(verses) {
    return ListView.builder(
      itemCount: verses.length,
        itemBuilder:  (context, index) {
          return _itemView(verses, index);
        },

    );
  }

  _itemView(verses, index) {
    Bible bible = verses[index] ?? 0;
    var verseID = bible.verseID;
    var verseTxt = bible.verseTxt;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
      child: Text(
        "$verseID $verseTxt",
        style: TextStyle(fontSize: fontSize),
        textAlign: TextAlign.start,
      ),
    );
  }

  _getChapter(bookID, chapter) {
    DBProvider db = DBProvider.provider;
    return db.allVerses(bookID, chapter);
  }
}
