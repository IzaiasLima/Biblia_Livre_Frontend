import 'package:freebible/models/bible.dart';
import 'package:freebible/models/favorites_dao.dart';
import 'package:freebible/services/base_bloc.dart';
import 'package:freebible/utils/constants.dart';

class FavoritesBloc extends BaseBloc<List<Bible>>{
  FavoritesDao _dao = FavoritesDao();

  Future<List<Bible>> favorites(FavoriteType type) async {
    try {
      List<Bible> verses = await _dao.favorites(type);
      add(verses);
      return verses;
    } catch (e) {
      addError(e);
      return null;
    }
  }
}