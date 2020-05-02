/**
 * Devolve o texto passado como parâmetro, retirand os trechos entre [], ou seja,
 * as observações, referências e traduções alteranativas.
 **/

String cleanVerse(String verseText) {
  if (verseText == null) return "";

  List<String> listChars = verseText.split("");
  List<String> newText = [];
  bool isReference = false;

  listChars.forEach((f) {
    if (f == "[") {
      isReference = true;
    } else if (f == "]") {
      isReference = false;
    } else if (!isReference) {
      if (newText.isEmpty || !(newText.last == " " && f == " ")) {
        newText.add(f);
      }
    }
  });
  return newText.join("");
}

/**
 * Devolve o texto passado como parâmetro, acrescido da tag <bold>
 *
 **/
String textTagged(String text, String term) {
  if (term.isEmpty) return text;

  List<String> terms = term.trim().split(" ");

  terms.forEach((part) {
    String termLC = part.toLowerCase();

    List<String> spanList = text.toLowerCase().split(termLC);
    int i = 0;
    String textTemp = "";

    spanList.forEach((v) {
      if (v.isNotEmpty) {
        textTemp += text.substring(i, i + v.length);
        i += v.length;
      }
      if (i < text.length) {
        textTemp += "<bold>${text.substring(i, i + part.length)}</bold>";
        i += part.length;
      }
    });
    text = textTemp;
  });
  return text;
}

String trunk(String text, length) {
  List<String> ret = [];
  int max = 0;

  List list = text.split(" ");

  list.forEach((l) {
    int len = l.length;
    if ((max + len) < length) {
      ret.add("$l ");
      max += len;
    } else {
      max = length;
    }
  });

  return "${ret.join("")}...";
}

String dotAtEnd(String txt) {
  txt = cleanVerse(txt);

  String firstChar = txt.substring(0, 1).toUpperCase();
  String lastChar = txt.substring(txt.length - 1);

  if ("?!".contains(lastChar))
    return "$firstChar${txt.substring(1, txt.length)}";

  return "$firstChar${txt.substring(1, txt.length - 1)}.";
}
