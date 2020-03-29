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
