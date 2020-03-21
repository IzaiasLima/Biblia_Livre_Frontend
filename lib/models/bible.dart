import 'dart:convert';

Bible bibleFromJson(String str) => Bible.fromMap(json.decode(str));

String bibleToJson(Bible data) => json.encode(data.toMap());

class Bible {
  int book;
  int chapter;
  int verse;
  String scripture;
  int testament;

  Bible({
    this.book,
    this.chapter,
    this.verse,
    this.scripture,
    this.testament,
  });

  factory Bible.fromMap(Map<String, dynamic> json) => Bible(
    book: json["Book"],
    chapter: json["Chapter"],
    verse: json["Verse"],
    scripture: json["Scripture"],
    testament: json["Testament"],
  );

  Map<String, dynamic> toMap() => {
    "Book": book,
    "Chapter": chapter,
    "Verse": verse,
    "Scripture": scripture,
    "Testament": testament,
  };
}
