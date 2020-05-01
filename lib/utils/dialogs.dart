import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freebible/models/favorite.dart';
import 'package:freebible/models/verse.dart';
import 'package:freebible/services/favorites_bloc.dart';

import 'constants.dart';

bottomSheetCopyRemove(
    context, FavoritesBloc _bloc, Favorite favorite, [isRemovable=false]) {
  Verse verse = favorite.verse;

  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return Container(
        color: accent,
        height: 50,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _backButton(context),
                  Expanded(
                    flex: 2,
                    child: Container(),
                  ),
                  _favoriteButton(context, _bloc, favorite, isRemovable),
                  _copyButton(context, verse),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

bottomSheetCopyFavorite(context, Verse verse) {
  FavoritesBloc _bloc = FavoritesBloc();
  Favorite favorite = Favorite.of(verse);

  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return Container(
        color: primary,
        height: 50,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  _backButton(context),
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: 50,
                    ),
                  ),
                  _favoriteButton(context, _bloc, favorite, false),
                  _copyButton(context, verse),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

_backButton(context) {
  return Expanded(
    child: IconButton(
        alignment: Alignment.topLeft,
        icon: Icon(
          Icons.arrow_back,
          color: background,
          size: 30,
        ),
        onPressed: () {
          Navigator.pop(context);
        }),
  );
}

_favoriteButton(context, bloc, favorite, isRemovable) {
  return Expanded(
    child: isRemovable
        ? IconButton(
            tooltip: "Excluir dos favoritos",
            icon: Icon(
              Icons.delete_outline,
              color: background,
              size: 30,
            ),
            onPressed: () {
              bloc.remove(favorite);
              Navigator.pop(context);
            })
        : IconButton(
            tooltip: "Favoritar",
            icon: Icon(
              Icons.favorite_border,
              color: background,
              size: 28,
            ),
            onPressed: () {
              favorite.type = FavoriteType.MINE.index;
              bloc.include(favorite);
              Navigator.pop(context);
            }),
  );
}

_copyButton(context, verse) {
  return Expanded(
    child: IconButton(
      tooltip: "Copiar",
      icon: Icon(
        Icons.content_copy,
        color: background,
      ),
      onPressed: (() {
        String txt = "${verse.verseTxt}\n${verse.reference()}";
        Clipboard.setData(ClipboardData(text: txt));
        Navigator.pop(context);
      }),
    ),
  );
}
