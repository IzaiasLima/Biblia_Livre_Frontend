import 'dart:async';

import 'package:freebible/models/favorite.dart';
import 'package:freebible/models/favorites_dao.dart';
import 'package:freebible/services/base_bloc.dart';
import 'package:freebible/utils/constants.dart';

class FavoritesBloc extends BaseBloc<List<Favorite>> {
  final FavoriteDao _dao = FavoriteDao();

  void include(Favorite favorite) async {
    if (favorite != null) {
      _dao.include(favorite);
    }
  }

  void remove(Favorite favorite) async {
    if (favorite != null) {
      _dao.remove(favorite);
    }
    favorites(favorite.type);
  }

  Future<List<Favorite>> favorites(int type) async {
    try {
      List<Favorite> favorites = await _dao.favorites(type);
      add(favorites);
      return favorites;
    } catch (e) {
      addError(e);
      return null;
    }
  }

  Future<Favorite> history() async {
    try {
      int type = FavoriteType.HISTORY.index;
      List<Favorite> hist = await favorites(type);
      return (hist != null) ? hist.last : null;
    } catch (_) {
      return null;
    }
  }
}
