import 'package:flutter/material.dart';
import 'package:freebible/models/books.dart';

import 'package:freebible/utils/db.dart';

class AlphaOrderPage extends StatefulWidget {
  @override
  _AlphaOrderPageState createState() => _AlphaOrderPageState();
}

class _AlphaOrderPageState extends State<AlphaOrderPage> {
  DBProvider db = DBProvider.provider;
  List<dynamic> bib;

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
      itemCount: (bib != null) ? bib.length : 0,
      itemBuilder: (context, index) {
        return _itemView(index);
      },
    );
  }

  _itemView(index) {
    Books book = bib[index];

    return ListTile(
      title: Text(
        book.bookName,
        style: TextStyle(fontSize: 20),
      ),
      onTap: () {
        print(book.book);
      },
    );
  }

  _loadList() async {
    var temp = await _consultar();

    setState(() {
      bib = temp;
    });
  }

  _consultar() async {
    DBProvider instance = DBProvider.provider;
    var res = await instance.allRows();

    List list = res.isNotEmpty ? res.map((l) => Books.fromMap(l)).toList() : [];
    return list;
  }
}
