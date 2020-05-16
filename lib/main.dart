import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:freebible/pages/home_page.dart';
import 'package:freebible/services/books_bloc.dart';
import 'package:freebible/utils/constants.dart';

final BooksBloc booksBloc = BooksBloc();

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        canvasColor: background,
        primaryColor: accent,
        backgroundColor: background,
        accentColor: accent,
      ),
      home: HomePage(),
    );
  }
}

