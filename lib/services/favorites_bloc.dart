import 'dart:async';
import 'dart:math';

import 'package:freebible/models/favorite.dart';
import 'package:freebible/models/favorites_dao.dart';
import 'package:freebible/models/verse.dart';
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

  Future<List<Favorite>> favorites(int type, {String order}) async {
    try {
      order = order ?? "Book, Chapter, Verse";
      List<Favorite> favorites = await _dao.favorites(type, order);
      add(favorites);
      return favorites;
    } catch (e) {
      addError(e);
      return null;
    }
  }

  Future<Verse> randomVerse() async {
    try {
      int type = FavoriteType.OTHERS.index;
      List<Favorite> hist = await favorites(type);

      if (hist == null) return null;

      var rng = new Random();
      int rndId = rng.nextInt(hist.length);
      return hist.elementAt(rndId).verse;

    } catch (_) {
      return null;
    }
  }

  Future<Favorite> history() async {
    try {
      int type = FavoriteType.HISTORY.index;
      List<Favorite> hist = await favorites(type, order: "Favorites_Id");
      return (hist != null) ? hist.last : null;
    } catch (_) {
      return null;
    }
  }
}
