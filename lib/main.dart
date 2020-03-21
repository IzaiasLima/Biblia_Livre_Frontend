import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:freebible/pages/home_page.dart';

Color primary = Color(0xff6785a1);
Color accent = Color(0xff5b6975);
Color background = Color(0xffe4edf5);

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

