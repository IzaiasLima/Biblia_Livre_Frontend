import 'dart:convert';

Books booksFromJson(String str) => Books.fromMap(json.decode(str));

String booksToJson(Books data) => json.encode(data.toMap());

class Books {
  int testament;
  int book;
  String bookName;
  int chapters;
  int seq;

  Books({
    this.testament,
    this.book,
    this.bookName,
    this.chapters,
    this.seq,
  });

  factory Books.fromMap(Map<String, dynamic> json) => Books(
    testament: json["Testament"],
    book: json["Book"],
    bookName: json["BookName"],
    chapters: json["Chapters"],
    seq: json["Seq"],
  );

  Map<String, dynamic> toMap() => {
    "Testament": testament,
    "Book": book,
    "BookName": bookName,
    "Chapters": chapters,
    "Seq": seq,
  };
}