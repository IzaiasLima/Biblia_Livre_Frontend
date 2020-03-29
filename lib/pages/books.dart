import 'package:flutter/material.dart';
import 'package:freebible/models/book.dart';
import 'package:freebible/pages/chapter.dart';
import 'package:freebible/pages/home_page.dart';
import 'package:freebible/pages/search_page.dart';

import 'package:freebible/services/db.dart';
import 'package:freebible/utils/nav.dart';
import 'package:freebible/utils/constants.dart';

class BooksPage extends StatefulWidget {
  // DBProvider db = DBProvider.provider;
  final ViewOptions viewOptions;

  BooksPage(this.viewOptions);

  @override
  _BooksPageState createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  Icon icon = new Icon(Icons.search, color: background);

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          ButtonBar(
            children: <Widget>[
              IconButton(
                icon: icon,
                onPressed: () {
                  push(context, SearchPage());
                },
              ),
            ],
          ),
        ],
        title: _title(),
      ),
      body: _body(),
    );
  }

  _title() {
    var title;

    switch (widget.viewOptions) {
      case ViewOptions.oldTestament:
        {
          title = "Velho Testamento";
          break;
        }
      case ViewOptions.newTestament:
        title = "Novo Testamento";
        break;
      default:
        title = "Todos os livros";
    }
    return Text(title);
  }

  _body() {
    return FutureBuilder(
        future: _loadBookList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Book> books = snapshot.data;
            return ListView.builder(
              itemExtent: 45,
              itemCount: (books != null) ? books.length : 0,
              itemBuilder: (context, index) {
                return _itemView(context, books, index);
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  _itemView(context, books, index) {
    Book book = books[index];
    int idxBook = index;

    return ListTile(
      title: Text(
        book.bookName,
        style: TextStyle(fontSize: fontSize),
      ),
      onTap: () {
        push(context, ChapterPage(books, idxBook));
      },
    );
  }

  _loadBookList() async {
    DBProvider db = DBProvider.provider;
    List result;

    switch (widget.viewOptions) {
      case ViewOptions.oldTestament:
        {
          result = await db.oldTestamentList();
          break;
        }
      case ViewOptions.newTestament:
        {
          result = await db.newTestamentList();
          break;
        }
      default:
        {
          result = await db.allBooksList();
        }
    }
    return result;
  }
}
