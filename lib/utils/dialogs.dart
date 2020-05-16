import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freebible/models/favorite.dart';
import 'package:freebible/models/verse.dart';
import 'package:freebible/services/favorites_bloc.dart';
import 'package:freebible/utils/text_utils.dart';
import 'package:share/share.dart';

import 'constants.dart';

bottomSheetSaved(context, marked, bloc, favorite) {
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                      child: Text(
                        (marked)
                            ? "LEITURA JÁ REGISTRADA"
                            : "REGISTRAR COMO LIDO",
                        style: TextStyle(color: background),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        if (marked) return;
                        bloc.include(favorite);
                      }),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

bottomSheetCopyRemove(context, bloc, Favorite favorite, [isRemovable = false]) {
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
                  _favoriteButton(context, bloc, favorite, isRemovable),
                  _copyButton(context, verse),
                  _shareButton(context, verse),
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
                  _shareButton(context, verse),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

_shareButton(context, Verse verse) {
  return Builder(builder: (BuildContext context) {
    return IconButton(
      alignment: Alignment.topLeft,
      icon: Icon(
        Icons.share,
        color: background,
        size: 30,
      ),
      onPressed: () {
        Navigator.pop(context);
        final text = "${cleanVerse(verse.verseTxt)} \n${verse.reference()}";
        final RenderBox box = context.findRenderObject();
        Share.share(
          text,
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
        );
      },
    );
  });
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
              size: 30,
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
        size: 28,
      ),
      onPressed: (() {
        final txt = "${cleanVerse(verse.verseTxt)} \n${verse.reference()}";
        Clipboard.setData(ClipboardData(text: txt));
        Navigator.pop(context);
      }),
    ),
  );
}
