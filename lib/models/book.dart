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
  List<int> markedList =[];

  Book({
    this.testament,
    this.bookID,
    this.bookName,
    this.chapters,
    this.seq,
  });

  get chaptersList => _chaptersList();

  factory Book.fromMap(Map<String, dynamic> json) => Book(
    testament: json["Testament"],
    bookID: json["Book"],
    bookName: json["BookName"],
    chapters: json["Chapters"],
    seq: json["Seq"],
  );

  _chaptersList() {
    List<int> list = [];
    for (int chapter = 0; chapter < this.chapters; chapter++) {
      list.add(chapter + 1);
    }
    return list;
  }

  bool isMarked(int i) => this.markedList.contains(i);

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