import 'dart:convert';

import 'package:freebible/models/verse.dart';
import 'package:freebible/utils/constants.dart';

Favorite favoritesFromJson(String str) => Favorite.fromMap(json.decode(str));

String favoritesToJson(Favorite data) => json.encode(data.toMap());

class Favorite extends Verse {
  int type;
  Verse verse;

  Favorite.of(Verse verse) {
    this.type = FavoriteType.MINE.index;
    this.verse = verse;
  }

  Favorite.marked({bookID, chapter}) {
    Verse verse = Verse(bookID: bookID, chapter: chapter);
    verse.verseID = 1;
    this.type = FavoriteType.MARKED.index;
    this.verse = verse;
  }

  Favorite({this.type, this.verse});

  factory Favorite.fromMap(Map<String, dynamic> json) => Favorite(
        type: json["Type"],
        verse: Verse.fromMap(json),
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
