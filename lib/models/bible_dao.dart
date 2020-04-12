import 'package:freebible/models/base_dao.dart';
import 'package:freebible/models/bible.dart';

class BibleDao extends BaseDAO<Bible> {
  String get tableName => "Bible";

  String get booksTable => "BooksList";

  @override
  Bible fromMap(Map<String, dynamic> map) {
    return Bible.fromMap(map);
  }

  Future<List<Bible>> chapterVerses(bookID, chapter) async {
    return await query(
        "select * from $tableName where Book = ? and Chapter = ?",
        [bookID, chapter]);
  }

  Future<List<Bible>> versesByWords(String searchText) async {
    if (searchText == null) return null;

    searchText = searchText.replaceAll(" ", "%");

    String sql = "SELECT * FROM $booksTable as L "
        "INNER JOIN $tableName as B ON (B.Book = L.Book) "
        "WHERE Scripture LIKE '%?%' "
        "ORDER BY Book";
    return await query(sql.replaceAll("?", searchText));
  }
}
