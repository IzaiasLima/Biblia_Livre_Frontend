import 'package:flutter/material.dart';

import 'package:freebible/utils/constants.dart';

class OldTestamentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _body();
  }

  _body() {
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primary,
        title: Text(appTitle),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: background,
        child: Text(
          "Antigo Testamento",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
