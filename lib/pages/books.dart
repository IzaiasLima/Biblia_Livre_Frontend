import 'package:flutter/material.dart';
import 'package:freebible/models/book.dart';
import 'package:freebible/pages/chapter.dart';
import 'package:freebible/pages/home_page.dart';

import 'package:freebible/utils/db.dart';
import 'package:freebible/utils/nav.dart';
import 'package:freebible/utils/constants.dart';
import 'package:freebible/widgets/dlg_search.dart';

class BooksPage extends StatelessWidget {
  // DBProvider db = DBProvider.provider;
  final ViewOptions viewOptions;

  BooksPage(this.viewOptions);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          ButtonBar(
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.search,
                  size: 25,
                  color: background,
                ),
                onPressed: () {
                  search(context);
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
    DBProvider instance = DBProvider.provider;
    List result;

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
