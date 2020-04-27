import 'package:freebible/models/favorite.dart';
import 'package:freebible/models/verse.dart';

import 'base_dao.dart';

class FavoriteDao extends BaseDAO<Favorite> {
  @override
  String get tableName => "Favorites";

  String get bibleTable => "Bible";

  String get booksTable => "BooksList";

  @override
  Favorite fromMap(Map<String, dynamic> map) {
    return Favorite.fromMap(map);
  }

  void include(Favorite favorite) async {
    try {
      await save(favorite);
    } catch (_) {
    }
  }

  void remove(Favorite favorite) async {
    delete(favorite);
  }

  void delete(Favorite favorite) async {
    Verse verse = favorite.verse;
    String sql = "delete from $tableName where "
        "Type=? and Book=? and Chapter=? and Verse=?";
    List<Favorite> list = await query(
        sql, [favorite.type, verse.bookID, verse.chapter, verse.verseID]);
  }

  Future<List<Favorite>> favorites(int type, order) async {
    String sql = "SELECT * FROM $booksTable as L "
        "INNER JOIN $tableName as F ON (F.Book = L.Book) "
        "INNER JOIN $bibleTable as B "
        "ON (B.Book = F.Book "
        "AND B.Chapter = F.Chapter "
        "AND B.Verse = F.Verse) "
        "WHERE F.Type=? "
        "ORDER BY $order";
    return await query(sql, [type]);
  }
}
