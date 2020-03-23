import 'package:flutter/material.dart';

Future push(BuildContext context, Widget page) {
  return Navigator.push(context,
      MaterialPageRoute(builder: (BuildContext context) {
        return page;
      }));
}

void goHome(BuildContext context) {
  Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
}