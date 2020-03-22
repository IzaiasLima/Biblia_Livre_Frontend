import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:freebible/pages/read_text.dart';
import 'package:freebible/utils/constants.dart';

import 'package:freebible/utils/db.dart';
import 'package:freebible/utils/nav.dart';

class ChapterPage extends StatefulWidget {
  @override
  _ChapterPageState createState() => _ChapterPageState();
}

class _ChapterPageState extends State<ChapterPage> {
  DBProvider db = DBProvider.provider;
  List<int> chapters = [];

  @override
  Widget build(BuildContext context) {
    _loadList();
    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
      ),
      body: _body(),
    );
  }

  _body() {
    return GridView.builder(
        itemCount: chapters.length,
        padding: EdgeInsets.all(16),
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
        itemBuilder: (context, index) {
          return _itemView(index);
        });
  }

  _itemView(index) {
    int chapter = chapters[index];

    return GestureDetector(
      child: Container(
        //alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 0, right: 16),
        child: Text(
          "$chapter",
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.end,
        ),
      ),
      onTap: (){
        push(context, ReadTextPage(chapter));
      },
    );
  }

  _loadList() async {
    var temp = await _getChapters();

    setState(() {
      chapters = temp;
    });
  }

  _getChapters() async {
//    DBProvider instance = DBProvider.provider;
//    var res = await instance.allRows();

    List<int> list = [
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10,
      11,
      12,
      13,
      14,
      15,
      16,
      17,
      18,
      19,
      20,
      21,
      22,
      23,
      24,
      25,
      26,
      27,
      28,
      29,
      30,
      31,
      32,
      33,
      34,
      35,
      26,
      37,
      38,
      39,
      40,
      41,
      42,
      43,
      44,
      45,
      36,
      47,
      48,
      49,
      50,
      51,
      52,
      53,
      54,
      55,
      56,
      57,
      58,
      59,
      60,
      61,
      62,
      63
    ];
    return list;
  }
}
