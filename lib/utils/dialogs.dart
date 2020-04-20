import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freebible/models/verse.dart';
import 'package:freebible/models/favorite.dart';
import 'package:freebible/services/favorites_bloc.dart';
import 'package:freebible/utils/text_utils.dart';

import 'constants.dart';

bottomSheetCopyRemove(context, FavoritesBloc _bloc, Favorite favorite, isRemovable) {
  Verse verse = favorite.verse;
  String txt = trunk(verse.verseTxt, 33);

  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return Container(
        color: background,
        height: 110,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16, top: 16, right: 5, bottom: 0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    "$txt\n${verse.reference()}",
                    style: TextStyle(
                      color: primary,
                      fontSize: fontSize - 2,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                    child: Text(
                      isRemovable ? "REMOVER" : "FAVORITAR",
                      style: TextStyle(
                        color: isRemovable ? Colors.redAccent : primary,
                        fontSize: fontSize - 1,
                      ),
                    ),
                    onPressed: (() {
                      if (isRemovable)
                        _bloc.remove(favorite);
                      else {
                        favorite.type = FavoriteType.MINE.index;
                        _bloc.include(favorite);
                      }
                      Navigator.pop(context);
                    }),
                  ),
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
  String txt = trunk(verse.verseTxt, 33);

  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return Container(
        color: background,
        height: 110,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16, top: 16, right: 5, bottom: 0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    "$txt\n${verse.reference()}",
                    style: TextStyle(
                      color: primary,
                      fontSize: fontSize - 2,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                    child: Text(
                      "FAVORITAR",
                      style: TextStyle(
                        color: primary,
                        fontSize: fontSize - 1,
                      ),
                    ),
                    onPressed: (() {
                      _bloc.include(favorite);
                      Navigator.pop(context);
                    }),
                  ),
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

Widget _copyButton(context, verse) {
  return FlatButton(
    child: Text(
      "COPIAR",
      style: TextStyle(
        color: primary,
        fontSize: fontSize - 1,
      ),
    ),
    onPressed: (() {
      String txt = "${verse.verseTxt}\n${verse.reference()}";
      Clipboard.setData(
          ClipboardData(text: txt));
      Navigator.pop(context);
    }),
  );
}
