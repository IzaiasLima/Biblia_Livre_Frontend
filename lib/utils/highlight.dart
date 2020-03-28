import 'package:flutter/material.dart';

highlight(BuildContext context, String text, String term, double fontSize) {
  TextStyle textStyle = TextStyle(color: Colors.black, fontSize: fontSize);
  TextStyle textStyleHighlight =
      TextStyle(color: Colors.red[700], fontSize: fontSize);

  if (term.isEmpty) return Text(text, style: textStyle);

  List<InlineSpan> children = [];
  List<String> terms = term.split(" ");

  terms.forEach((part) {
    String termLC = part.toLowerCase();

    List<String> spanList = text.toLowerCase().split(termLC);
    int i = 0;
    spanList.forEach((v) {
      if (v.isNotEmpty) {
        children.add(
            TextSpan(text: text.substring(i, i + v.length), style: textStyle));
        i += v.length;
      }
      if (i < text.length) {
        children.add(TextSpan(
            text: text.substring(i, i + part.length),
            style: textStyleHighlight));
        i += part.length;
      }
    });
  });
  return RichText(text: TextSpan(children: children));
}
