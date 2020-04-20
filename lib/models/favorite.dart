
import 'dart:convert';

import 'package:freebible/models/verse.dart';
import 'package:freebible/utils/constants.dart';

Favorite favoritesFromJson(String str) => Favorite.fromMap(json.decode(str));

String favoritesToJson(Favorite data) => json.encode(data.toMap());

class Favorite extends Verse {
  int type;
  Verse verse;
//  int id;
//  int bookID;
//  int chapter;
//  int verseID;
//  String bookName;
//  String verseTxt;


  Favorite.of(Verse verse) {
    this.type = FavoriteType.MINE.index;
    this.verse = verse;
  }

//  Favorite.of(Verse bible){
//    this.type = FavoriteType.ALL.index;
//    this.bookID = bible.bookID;
//    this.chapter = bible.chapter;
//    this.verseID = bible.verseID;
//    this.bookName = bible.bookName;
//    this.verseTxt = bible.verseTxt;
//  }

  Favorite({
    this.type,
    this.verse
//    this.bookID,
//    this.chapter,
//    this.verseID,
//    this.bookName,
//    this.verseTxt
  });

  factory Favorite.fromMap(Map<String, dynamic> json) => Favorite(
    type: json["Type"],
    verse: Verse.fromMap(json),
//    bookID: json["Book"],
//    chapter: json["Chapter"],
//    verseID: json["Verse"],
//    verseTxt: json["Scripture"],
//    bookName: json["BookName"],
  );

  @override
  Map<String, dynamic> toMap() => {
    "Type": type,
    "Book": verse.bookID,
    "Chapter": verse.chapter,
    "Verse": verse.verseID
  };

  @override
  String toString() {
    return 'Favorite{type: $type, ${verse.toString()}}';
  }

}