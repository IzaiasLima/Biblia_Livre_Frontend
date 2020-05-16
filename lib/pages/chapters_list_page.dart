import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:freebible/main.dart';
import 'package:freebible/models/book.dart';
import 'package:freebible/pages/chapter_page.dart';
import 'package:freebible/pages/search_page.dart';
import 'package:freebible/utils/constants.dart';
import 'package:freebible/utils/navigator.dart';
import 'package:freebible/utils/widgets.dart';

class ChaptersListPage extends StatefulWidget {
  final idxBook;
  final List<Book> books;

  ChaptersListPage(this.books, this.idxBook);

  @override
  _ChaptersListPageState createState() => _ChaptersListPageState();
}

class _ChaptersListPageState extends State<ChaptersListPage> {
  Book book;
  List<int> chaptersList;

  @override
  void initState() {
    book = widget.books[widget.idxBook];
    booksBloc.markedChapters(book);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
    return StreamBuilder(
        stream: booksBloc.stream, // ,
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return centerText("Erro lendo a lista de capítulos.");

          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          return GridView.builder(
            itemCount: book.chapters,
            padding: EdgeInsets.all(16),
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
            itemBuilder: (context, index) => _itemView(context, index),
          );
        });
  }

  _itemView(context, index) {
    int chapter = (book == null) ? 0 : book.chaptersList[index];

    return InkWell(
      child: Container(
        padding: EdgeInsets.only(left: 0, right: 16),
        child: Text(
          "$chapter",
          style: TextStyle(
            color: book.isMarked(chapter) ? Colors.blueAccent : Colors.black,
            fontSize: fontSize,
          ),
          textAlign: TextAlign.end,
        ),
      ),
      onTap: () {
        push(context, ChapterPage(chapter, widget.idxBook, widget.books));
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
