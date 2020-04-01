import 'package:flutter/material.dart';

import 'package:freebible/models/bible.dart';
import 'package:freebible/services/db.dart';
import 'package:freebible/utils/constants.dart';
import 'package:freebible/utils/dialogs.dart';
import 'package:freebible/utils/nav.dart';
import 'package:freebible/utils/text_utils.dart';

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

class _ShowChapterPageState extends State<ShowChapterPage>
    with AutomaticKeepAliveClientMixin {
  String bookName;
  String verseText;
  int bookID;
  int chapter;

  _ShowChapterPageState(
      this.bookName, this.bookID, this.chapter, this.verseText);

  get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
    return FutureBuilder(
        future: _getChapterText(bookID, chapter),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          verses = snapshot.data;
          return _listView(verses);
        });
  }

  _listView(verses) {
    return ListView.builder(
      controller: ScrollController(),
      addAutomaticKeepAlives: true,
      itemCount: verses.length,
      itemBuilder: (context, index) {
        return _itemView(context, verses, index);
      },
    );
  }

  _itemView(context, verses, index) {
    Bible bible = verses[index] ?? 0;
    String verseTxt = verseWithoutReferences(bible.verseTxt);

    Color colorText =
        (bible.verseTxt == this.verseText) ? Colors.black : Colors.black54;

    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
        child: Text(
          "${bible.verseID} $verseTxt",
          style: TextStyle(color: colorText, fontSize: fontSize),
        ),
      ),
      onTap: () => Scaffold.of(context).hideCurrentSnackBar(),
      onLongPress: () {
        _onLongPress(
            context, bible.bookName, chapter, bible.verseID, bible.verseTxt);
      },
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
