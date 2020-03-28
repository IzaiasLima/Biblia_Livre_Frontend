import 'dart:convert';

Bible bibleFromJson(String str) => Bible.fromMap(json.decode(str));

String bibleToJson(Bible data) => json.encode(data.toMap());

class Bible {
  int testament;
  int bookID;
  int chapter;
  int verseID;

  String bookName;
  String verseTxt;

  Bible({
    this.testament,
    this.bookID,
    this.chapter,
    this.verseID,
    this.verseTxt,
    this.bookName,
  });

  factory Bible.fromMap(Map<String, dynamic> json) => Bible(
        testament: json["Testament"],
        bookID: json["Book"],
        chapter: json["Chapter"],
        verseID: json["Verse"],
        verseTxt: json["Scripture"],
        bookName: json["BookName"],
      );

  Map<String, dynamic> toMap() => {
        "Testament": testament,
        "Book": bookID,
        "Chapter": chapter,
        "Verse": verseID,
        "Scripture": verseTxt,
        "BookName": bookName,
      };

  @override
  String toString() {
    return 'Bible{bookID: $bookID, bookName: $bookName, chapter: $chapter, verseID: $verseID, verseTxt: $verseTxt}';
  }
}
