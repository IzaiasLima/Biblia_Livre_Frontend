import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:freebible/utils/constants.dart';
import 'package:freebible/pages/show_chapter.dart';
import 'package:freebible/utils/nav.dart';
import 'package:styled_text/styled_text.dart';
import 'package:freebible/models/bible.dart';
import 'package:freebible/services/db.dart';
import 'package:freebible/utils/dialogs.dart';
import 'package:freebible/utils/text_utils.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => new _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = new TextEditingController();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  List<Bible> _listVerses;
  bool _isCopying = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: accent,
        title: Text("Pesquisa"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close, color: inverse),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: _inputSearch(),
          ),
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: _showVerses(),
          )
        ],
      ), // _body(),
    );
  }

  _inputSearch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            height: 40,
            child: TextField(
              controller: _controller,
              autofocus: true,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: primary, width: 2, style: BorderStyle.solid),
                ),
              ),
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.search,
            color: primary,
            size: 26,
          ),
          onPressed: () {
            setState(() {
              _getVerses();
            });
          },
        )
      ],
    );
  }

  _showVerses() {
    return ListView.builder(
      key: _listKey,
      shrinkWrap: true,
      itemCount: (_listVerses != null) ? _listVerses.length : 0,
      itemBuilder: (context, index) {
        return _itemView(context, index);
      },
    );
  }

  _itemView(context, index) {
    Bible bible = _listVerses[index];
    String search = _controller.text;

    var verse = bible.verseTxt;
    var ref = "${bible.bookName} ${bible.chapter}:${bible.verseID}";
    var verseTagged = textTagged(verse, search);
    var size = fontSize - 2;

    return ListTile(
      contentPadding: EdgeInsets.only(left: 16, right: 12),
      title: StyledText(
        text: "<bold>$ref</bold>",
        styles: {
          'bold': TextStyle(
            color: Colors.black,
            fontSize: size,
            fontWeight: FontWeight.bold,
          ),
        },
      ),
      subtitle: StyledText(
        text: "<normal>$verseTagged</normal>",
        styles: {
          'normal': TextStyle(
            color: Colors.black,
            fontSize: size,
            fontWeight: FontWeight.normal,
          ),
          'bold': TextStyle(
            color: Colors.blue[700],
            fontSize: size,
            fontWeight: FontWeight.bold,
          ),
        },
      ),
      onLongPress: (() {
        _isCopying = true;
        copyToClipboard(context, ref, verse);
      }),
      onTap: (() {
        if (_isCopying) {
          Scaffold.of(context).hideCurrentSnackBar();
          _isCopying = false;
        } else { push(context, ShowChapterPage(
              bible.bookName,
              bible.bookID,
              bible.chapter,
              bible.verseTxt,
            ),
          );
        }
      }),
    );
  }

  _getVerses() async {
    String searchText = _controller.text;
    if (searchText.isEmpty || searchText.length < 2) return null;
    if (_listVerses != null) _listVerses.clear();

    DBProvider db = DBProvider.provider;
    var res = await db.searchVerses(searchText);

    setState(() {
      _listVerses = res;
    });
  }
}
