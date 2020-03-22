import 'package:flutter/material.dart';
import 'package:freebible/utils/constants.dart';

class ReadTextPage extends StatelessWidget {
  int chapter;

  ReadTextPage(this.chapter);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      child: Text(
        '''
    Lendo o capítulo: $chapter.\n
      Suspendisse commodo iaculis 
      magna ac accumsan. 
      Aliquam et sodales tellus. 
      Etiam id interdum mauris, 
      eu bibendum purus. Aliquam 
      scelerisque arcu nulla, a 
      porttitor eros aliquet vitae. 
      In est urna, maximus a 
      nibh scelerisque, venenatis 
      condimentum mi. 
      Cras fringilla varius tellus. 
      Nam at nunc varius, 
      euismod erat eu, finibus risus. 
      Aenean ultrices 
      non enim vitae hendrerit.''',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
