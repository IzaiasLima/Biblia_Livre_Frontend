import 'package:freebible/models/base_dao.dart';
import 'package:freebible/models/verse.dart';

class VerseDao extends BaseDAO<Verse> {
  @override
  String get tableName => "Bible";

  String get booksTable => "BooksList";

  @override
  Verse fromMap(Map<String, dynamic> map) {
    return Verse.fromMap(map);
  }

  Future<List<Verse>> chapterVerses(bookID, chapter) async {
    return await query(
        "select * from $tableName where Book = ? and Chapter = ?",
        [bookID, chapter]);
  }

  Future<List<Verse>> versesByWords(String searchText) async {
    if (searchText == null) return null;

    searchText = searchText.replaceAll(" ", "%");

    String sql = "SELECT * FROM $booksTable as L "
        "INNER JOIN $tableName as B ON (B.Book = L.Book) "
        "WHERE Scripture LIKE '%?%' "
        "ORDER BY Book";
    return await query(sql.replaceAll("?", searchText));
  }
}
