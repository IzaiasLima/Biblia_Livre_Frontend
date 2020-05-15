import 'dart:ui';

import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';

EasyRichText richText(String txt, String words, double size) {
  if (words == null) return null;

  List<EasyRichTextPattern> pattern = List<EasyRichTextPattern>();
  List<String> w = words.split(" ");

  w.forEach((f) => pattern.add(_pattern(f, size)));
  return EasyRichText(
    txt,
    defaultStyle: TextStyle(color: Colors.black, fontSize: size),
    patternList: pattern,
  );
}

EasyRichTextPattern _pattern(String fmt, double size) {
  return EasyRichTextPattern(
    targetString: fmt,
    style: TextStyle(
      color: Colors.blue,
      fontWeight: FontWeight.bold,
      fontSize: size,
    ),
  );
}
