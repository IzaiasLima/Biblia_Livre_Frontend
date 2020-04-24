import 'package:flutter/material.dart';
import 'package:freebible/models/book.dart';
import 'package:freebible/pages/chapter_page.dart';
import 'package:freebible/services/books_bloc.dart';
import 'package:freebible/utils/text_utils.dart';

Future push(BuildContext context, Widget page) {
  return Navigator.push(context,
      MaterialPageRoute(builder: (BuildContext context) {
        return page;
      }));
}

void goHome(BuildContext context) {
  Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
}

showChapter(context, verse) async {
  BooksBloc bloc = BooksBloc();
  try {
    List<Book> books = await bloc.book(verse.bookID);
    push(
      context,
      ChapterPage(verse.chapter, 0, books, verse.verseTxt),
    );
  } catch (e) {
    return centerText("Erro ao exibir o capítulo.");
  }
}