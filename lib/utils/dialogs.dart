
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';

copyToClipboard(context, ref, verseTxt) {
  var txt = ((verseTxt.length) > 25) ? "${verseTxt.substring(0, 25)}..." : verseTxt;

  Scaffold.of(context).showSnackBar(
    SnackBar(
      duration: Duration(seconds: 5),
      backgroundColor: accent,
      content: Text("$txt\n$ref"),
      action: SnackBarAction(
        label: "COPIAR",
        textColor: Colors.white,
        onPressed: () {
          Clipboard.setData(ClipboardData(text: "$verseTxt\n$ref"));
        },
      ),
    ),
  );
}