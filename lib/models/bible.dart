import 'dart:convert';

Bible bibleFromJson(String str) => Bible.fromMap(json.decode(str));

String bibleToJson(Bible data) => json.encode(data.toMap());

class Bible {
  int bookID;
  int chapter;
  int verseID;
  String verseTxt;
  int testament;

  Bible({
    this.bookID,
    this.chapter,
    this.verseID,
    this.verseTxt,
    this.testament,
  });

  factory Bible.fromMap(Map<String, dynamic> json) => Bible(
    bookID: json["Book"],
    chapter: json["Chapter"],
    verseID: json["Verse"],
    verseTxt: json["Scripture"],
    testament: json["Testament"],
  );

  Map<String, dynamic> toMap() => {
    "Book": bookID,
    "Chapter": chapter,
    "Verse": verseID,
    "Scripture": verseTxt,
    "Testament": testament,
  };
}
