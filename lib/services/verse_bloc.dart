import 'package:freebible/models/verse.dart';
import 'package:freebible/models/dao/verse_dao.dart';
import 'package:freebible/services/base_bloc.dart';

class VerseBloc extends BaseBloc<List<Verse>> {
  VerseDao _dao = VerseDao();

  Future<List<Verse>> bookVerses(bookID, chapter) async {
    try {
      List<Verse> verses = await _dao.chapterVerses(bookID, chapter);
      add(verses);
      return verses;
    } catch (e) {
      addError(e);
      return null;
    }
  }

  Future<List<Verse>> versesByWord(String searchText) async {
    if (searchText.trim().isEmpty) return null;

    try {
      List<Verse> verses = await _dao.versesByWords(searchText);
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
