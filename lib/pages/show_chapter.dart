import 'package:flutter/material.dart';

import 'package:freebible/models/bible.dart';
import 'package:freebible/services/db.dart';
import 'package:freebible/utils/constants.dart';
import 'package:freebible/utils/dialogs.dart';
import 'package:freebible/utils/nav.dart';
import 'package:styled_text/styled_text.dart';

class ShowChapterPage extends StatefulWidget {
  String bookName;
  String verseText;
  int bookID;
  int chapter;

  ShowChapterPage(this.bookName, this.bookID, this.chapter, this.verseText);

  @override
  _ShowChapterPageState createState() =>
      _ShowChapterPageState(bookName, bookID, chapter, verseText);
}

class _ShowChapterPageState extends State<ShowChapterPage> {
  String bookName;
  String verseText;
  int bookID;
  int chapter;

  _ShowChapterPageState(
      this.bookName, this.bookID, this.chapter, this.verseText);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$bookName, $chapter"),
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
      //onHorizontalDragEnd: (details) => _onHorizontalDrag(details),
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
    String verseText;

    if (bible.verseTxt == this.verseText) {
      verseText = "<special>${bible.verseID} ${bible.verseTxt}</special>";
    } else {
      verseText = "<normal>${bible.verseID} ${bible.verseTxt}</normal>";
    }

    return GestureDetector(
      onTap: () => Scaffold.of(context).hideCurrentSnackBar(),
      onLongPress: () {
        _onLongPress(
            context, bible.bookName, chapter, bible.verseID, bible.verseTxt);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
        child: StyledText(
          text: verseText,
          styles: {
            'normal': TextStyle(
              color: Colors.black54,
              fontSize: fontSize,
              fontWeight: FontWeight.normal,
            ),
            'special': TextStyle(
              color: Colors.black,
              fontSize: fontSize,
              fontWeight: FontWeight.normal,
            ),
          },
        ),
      ),
    );
  }

  _getChapterText(bookID, chapter) {
    if (bookID == null) return null;
    DBProvider db = DBProvider.provider;
    return db.allVerses(bookID, chapter);
  }

  _onLongPress(context, bookName, chapter, verseID, String verseTxt) {
    var ref = "$bookName, $chapter:$verseID";
    copyToClipboard(context, ref, verseTxt);
  }
}
