import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:freebible/models/bible.dart';
import 'package:freebible/models/book.dart';
import 'package:freebible/pages/chapter_page.dart';
import 'package:freebible/services/bible_bloc.dart';
import 'package:freebible/services/books_bloc.dart';
import 'package:freebible/utils/constants.dart';
import 'package:freebible/utils/dialogs.dart';
import 'package:freebible/utils/nav.dart';
import 'package:freebible/utils/text_utils.dart';
import 'package:styled_text/styled_text.dart';

class SearchPage extends StatefulWidget {
  final Testament testament;

  SearchPage([this.testament]);

  @override
  _SearchPageState createState() => new _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = new TextEditingController();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  BibleBloc _bloc = BibleBloc();
  BooksBloc _booksBloc = BooksBloc();
  bool _isCopying = false;
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    String title = "Pesquisa no ${widget.testament}";
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: accent,
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close, color: inverse),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
      body: _body(),
    );
  }

  _body() {
    return Column(
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
                    color: primary,
                    width: 2,
                    style: BorderStyle.solid,
                  ),
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
            _isSearching = true;
            _bloc.versesByWord(_controller.text);
          },
        )
      ],
    );
  }

  _showVerses() {
    List<Bible> verses;
    return StreamBuilder(
        stream: _bloc.stream,
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return centerText("Erro lendo a lista de versículos.");

          if (!snapshot.hasData && _isSearching)
            return Center(child: CircularProgressIndicator());

          verses = snapshot.data;

          if (verses == null)
            return centerText(
              "Informe a palavra a ser pesquisada.",
              color: Colors.black,
            );

          if (verses.length == 0) return centerText("Palavra não encontrada!");

          return _listView(verses);
        });
  }

  _listView(verses) {
    return Scrollbar(
      child: ListView.builder(
        key: _listKey,
        itemCount: verses.length,
        itemBuilder: (context, index) {
          return _itemView(context, verses, index);
        },
      ),
    );
  }

  _itemView(context, verses, index) {
    Bible bible = verses[index];
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
        } else {
          _showChapter(bible.bookID, bible.chapter, bible.verseTxt);
        }
      }),
    );
  }

  _showChapter(bookID, chapter, verseTxt) async {
    try {
      List<Book> books = await _booksBloc.book(bookID);
      push(
        context,
        ChapterPage(chapter, 0, books, verseTxt),
      );
    } catch (e) {
      return centerText("Erro ao exibir o capítulo.");
    }
  }

  @override
  void dispose() {
    _bloc.dispose();
    _booksBloc.dispose();
    super.dispose();
  }
}
