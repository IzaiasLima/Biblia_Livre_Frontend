import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:freebible/models/book.dart';
import 'package:freebible/pages/read_text.dart';
import 'package:freebible/utils/constants.dart';

import 'package:freebible/utils/db.dart';
import 'package:freebible/utils/nav.dart';

class ChapterPage extends StatelessWidget {
  DBProvider db = DBProvider.provider;
  final Book book;
  List<int> chaptersList;

  ChapterPage(this.book);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
      ),
      body: _body(),
    );
  }

  _body() {
    chaptersList = _getChaptersList(book.chapters);
    return GridView.builder(
        itemCount: book.chapters,
        padding: EdgeInsets.all(16),
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
        itemBuilder: (context, index) {
          return _itemView(context, index);
        });
  }

  _itemView(context, index) {
    int chapter = chaptersList[index] ?? 0;

    return GestureDetector(
      child: Container(
        padding: EdgeInsets.only(left: 0, right: 16),
        child: Text(
          "$chapter",
          style: TextStyle(fontSize: fontSize),
          textAlign: TextAlign.end,
        ),
      ),
      onTap: () {
        push(context, ReadTextPage(book.bookID, chapter));
      },
    );
  }

  _getChaptersList(int c) {
    List<int> list = [];

    for (int i = 0; i < c; i++) {
      list.add(i+1);
    }

    return list;
  }
}
