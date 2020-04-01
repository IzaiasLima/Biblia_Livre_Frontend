import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:freebible/models/book.dart';
import 'package:freebible/pages/read_chapter.dart';
import 'package:freebible/pages/search_page.dart';
import 'package:freebible/utils/constants.dart';

import 'package:freebible/utils/nav.dart';

class ChapterPage extends StatelessWidget {
  final idxBook;
  final List<Book> books;

  Book book;
  List<int> chaptersList;

  ChapterPage(this.books, this.idxBook);

  @override
  Widget build(BuildContext context) {
    book = books[idxBook];
    return Scaffold(
      appBar: AppBar(
        title: Text(book.bookName),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              size: 25,
              color: background,
            ),
            onPressed: () {
              push(context, SearchPage());
            },
          ),
          IconButton(
            icon: Icon(
              Icons.home,
              size: 25,
              color: background,
            ),
            onPressed: () {
              goHome(context);
            },
          ),
        ],
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
    int chapter =
        ((book == null) || (chaptersList == null)) ? 0 : chaptersList[index];

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
        push(context, ReadChapterPage(books, chapter, idxBook));
      },
    );
  }

  _getChaptersList(int c) {
    List<int> list = [];

    for (int i = 0; i < c; i++) {
      list.add(i + 1);
    }

    return list;
  }
}
