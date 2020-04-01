/**
 * Devolve o texto passado como parâmetro, retirand os trechos entre [], ou seja,
 * as observações, referências e traduções alteranativas.
 **/

String verseWithoutReferences(String verse) {
  List<String> listChars = verse.split("");
  List<String> newVerse = [];
  bool isReference = false;

  listChars.forEach((f) {
    if (f == "[") {
      isReference = true;
    } else if (f == "]") {
      isReference = false;
    } else if (!isReference) {
      if (newVerse.isEmpty || !(newVerse.last == " " && f == " ")) {
        newVerse.add(f);
      }
    }
  });
  return newVerse.join("");
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
