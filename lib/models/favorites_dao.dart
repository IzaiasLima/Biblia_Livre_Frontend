import 'package:freebible/utils/constants.dart';

import 'base_dao.dart';
import 'bible.dart';

class FavoritesDao extends BaseDAO<Bible> {
  String get tableName => "Favorites";

  String get bibleTable => "Bible";

  String get booksTable => "BooksList";

  @override
  Bible fromMap(Map<String, dynamic> map) {
    return Bible.fromMap(map);
  }

  Future<List<Bible>> favorites(FavoriteType type) async {
    String sql = "SELECT * FROM $booksTable as L "
        "INNER JOIN $tableName as F ON (F.Book = L.Book) "
        "INNER JOIN $bibleTable as B "
        "ON (B.Book = F.Book "
        "AND B.Chapter = F.Chapter "
        "AND B.Verse = F.Verse) "
        "WHERE F.Type=? "
        "ORDER BY Book, Chapter, Verse;";
    return await query(sql, [type.index]);
  }
}
