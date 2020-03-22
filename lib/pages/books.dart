import 'package:flutter/material.dart';
import 'package:freebible/models/book.dart';
import 'package:freebible/pages/chapter.dart';
import 'package:freebible/pages/home_page.dart';

import 'package:freebible/utils/db.dart';
import 'package:freebible/utils/nav.dart';
import 'package:freebible/utils/constants.dart';

class BooksPage extends StatefulWidget {
  final ViewOptions viewOptions;

  BooksPage(this.viewOptions);

  @override
  _BooksPageState createState() => _BooksPageState(viewOptions);
}

class _BooksPageState extends State<BooksPage> {
  DBProvider db = DBProvider.provider;
  List<dynamic> books = [];

  final ViewOptions viewOptions;

  _BooksPageState(this.viewOptions);

  @override
  Widget build(BuildContext context) {
    _loadBookList();

    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: _body(),
    );
  }

  _title() {
    var title;

    switch (viewOptions) {
      case ViewOptions.oldTestament:
        {
        title = "Velho Testamento";
          break;
        }
      case ViewOptions.newTestament:
        title = "Novo Testamento";
        break;
      default:
        title = "Ordem alfabética";
    }
    return Text(title);
  }

  _body() {
    return ListView.builder(
      itemExtent: 45,
      itemCount: (books != null) ? books.length : 0,
      itemBuilder: (context, index) {
        return _itemView(index);
      },
    );
  }

  _itemView(index) {
    Book book = books[index];

    return ListTile(
      title: Text(
        book.bookName,
        style: TextStyle(fontSize: fontSize),
      ),
      onTap: () {
        push(context, ChapterPage(book));
      },
    );
  }

  _loadBookList() async {
    var temp = await _dbQuery();

    setState(() {
      books = temp;
    });
  }

  _dbQuery() async {
    DBProvider instance = DBProvider.provider;
    var result;

    switch (viewOptions) {
      case ViewOptions.oldTestament:
        {
          result = await instance.oldTestamentList();
          break;
        }

      case ViewOptions.newTestament:
        {
          result = await instance.newTestamentList();
          break;
        }
      default:
        {
          result = await instance.allBooksList();
        }
    }
    return result;
  }
}
