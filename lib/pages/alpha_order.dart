import 'package:flutter/material.dart';
import 'package:freebible/models/books.dart';
import 'package:freebible/pages/chapter.dart';

import 'package:freebible/utils/db.dart';
import 'package:freebible/utils/nav.dart';

class AlphaOrderPage extends StatefulWidget {
  @override
  _AlphaOrderPageState createState() => _AlphaOrderPageState();
}

class _AlphaOrderPageState extends State<AlphaOrderPage> {
  DBProvider db = DBProvider.provider;
  List<dynamic> books;

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
    Books book = books[index];

    return ListTile(
      title: Text(
        book.bookName,
        style: TextStyle(fontSize: 20),
      ),
      onTap: () {
        push(context, ChapterPage());
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
    var res = await instance.allRows();

    List list = res.isNotEmpty ? res.map((l) => Books.fromMap(l)).toList() : [];
    return list;
  }
}
