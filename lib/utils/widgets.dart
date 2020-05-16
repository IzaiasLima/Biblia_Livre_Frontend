import 'dart:ui';

import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:freebible/utils/text_utils.dart';

Widget centerText(String msg, {color: Colors.redAccent, size: 14.0}) {
  return Center(
    child: Text(
      msg,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

EasyRichText richText(String txt, String words, double size) {
  List<EasyRichTextPattern> pattern = List<EasyRichTextPattern>();

  if (words != null) {
    List<String> w = words.split(" ");
    w.forEach((f) {
      pattern.add(_pattern(f, size));
      pattern.add(_pattern(capitalize(f), size));
    });
  }
  return EasyRichText(
    txt,
    defaultStyle: TextStyle(color: Colors.black, fontSize: size),
    patternList: pattern,
  );
}

_pattern(String fmt, double size) {
  return EasyRichTextPattern(
    targetString: fmt,
    style: TextStyle(
      color: Colors.blue,
      fontWeight: FontWeight.bold,
      fontSize: size,
    ),
  );
}
