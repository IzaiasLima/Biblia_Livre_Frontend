import 'package:freebible/models/base_dao.dart';
import 'package:freebible/models/book.dart';
import 'package:freebible/utils/constants.dart';

class BooksDao extends BaseDAO<Book> {
  @override
  String get tableName => "BooksList";

  @override
  Book fromMap(Map<String, dynamic> map) {
    return Book.fromMap(map);
  }

  Future<List<Book>> bookById(bookID) async {
    return await query(
        "select * from $tableName where Book=? order by Book", [bookID]);
  }

  Future<List<Book>> booksList(Testament testament) async {
    if (testament == Testament.ALL)
      return await query("select * from $tableName order by Seq");
    else {
      int t = (testament == Testament.AT) ? 1 : 2;
      return await query(
          "select * from $tableName where Testament=? order by Book", [t]);
    }
  }
}
