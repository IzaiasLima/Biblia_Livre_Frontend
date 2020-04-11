import 'package:freebible/models/base_dao.dart';
import 'package:freebible/models/bible.dart';

class BibleDao extends BaseDAO<Bible> {
  @override
  String get tableName => "Bible";
  String get joinTableName => "BooksList";

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

    String sql = "SELECT * FROM $joinTableName as L "
        "INNER JOIN $tableName as B ON (L.Book = B.Book) "
        "WHERE Scripture LIKE '%?%' "
        "ORDER BY Book";
    return await query(sql.replaceAll("?", searchText));
  }
}
