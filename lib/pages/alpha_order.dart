import 'package:flutter/material.dart';
import 'package:freebible/models/book.dart';
import 'package:freebible/pages/chapter.dart';


import 'package:freebible/utils/db.dart';
import 'package:freebible/utils/nav.dart';
import 'package:freebible/utils/constants.dart';

class AlphaOrderPage extends StatefulWidget {
  @override
  _AlphaOrderPageState createState() => _AlphaOrderPageState();
}

class _AlphaOrderPageState extends State<AlphaOrderPage> {
  DBProvider db = DBProvider.provider;
  List<dynamic> books = [];

  @override
  Widget build(BuildContext context) {
    _loadList();
    return Scaffold(
      appBar: AppBar(
        title: Text("Ordem alfabética"),
      ),
      body: _body(),
    );
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
        print("** $book");
        push(context, ChapterPage(book));
      },
    );
  }

  _loadList() async {
    var temp = await _consultar();

    setState(() {
      books = temp;
    });
  }

  _consultar() async {
    DBProvider instance = DBProvider.provider;
    return await instance.allBooksList();
  }
}
