import 'package:freebible/models/bible.dart';
import 'package:freebible/models/bible_dao.dart';
import 'package:freebible/services/base_bloc.dart';

class BibleBloc extends BaseBloc<List<Bible>> {
  BibleDao dao = BibleDao();

  Future<List<Bible>> bookVerses(bookID, chapter) async {
    try {
      List<Bible> verses = await dao.chapterVerses(bookID, chapter);
      add(verses);
      return verses;
    } catch (e) {
      addError(e);
      return null;
    }
  }

  Future<List<Bible>> versesByWord(String searchText) async {
    try {
      add(null);
      List<Bible> verses = await dao.versesByWords(searchText);
      add(verses);
      return verses;
    } catch (e) {
      addError(e);
      return null;
    }
  }

  List nextChapter(details, idxBook, chapter, books) {
    var book = books[idxBook];
    if (details.primaryVelocity.compareTo(0) == -1) {
      if (++chapter > book.chapters) {
        if (idxBook < books.length - 1) {
          chapter = 1;
          book = books[++idxBook];
        } else {
          chapter = book.chapters;
        }
      }
    } else {
      if (--chapter < 1) {
        if (idxBook > 0) {
          book = books[--idxBook];
          chapter = book.chapters;
        } else {
          chapter = 1;
        }
      }
    }
    return [idxBook, chapter];
  }
}
