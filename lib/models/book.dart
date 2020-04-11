import 'dart:convert';

import 'package:freebible/models/entity.dart';

Book booksFromJson(String str) => Book.fromMap(json.decode(str));

String booksToJson(Book data) => json.encode(data.toMap());

class Book extends Entity {
  int testament;
  int bookID;
  String bookName;
  int chapters;
  int seq;

  Book({
    this.testament,
    this.bookID,
    this.bookName,
    this.chapters,
    this.seq,
  });

  factory Book.fromMap(Map<String, dynamic> json) => Book(
    testament: json["Testament"],
    bookID: json["Book"],
    bookName: json["BookName"],
    chapters: json["Chapters"],
    seq: json["Seq"],
  );

  @override
  Map<String, dynamic> toMap() => {
    "Testament": testament,
    "Book": bookID,
    "BookName": bookName,
    "Chapters": chapters,
    "Seq": seq,
  };

  @override
  String toString() {
    return 'Book{book: $bookID, bookName: $bookName, chapters: $chapters}';
  }


}