import 'package:flutter/material.dart';

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