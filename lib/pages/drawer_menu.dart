import 'package:flutter/material.dart';
import 'package:freebible/pages/new_testament.dart';
import 'package:freebible/pages/old_testament.dart';
import 'package:freebible/utils/nav.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
                accountName: Text("Izaias Lima"),
                accountEmail: Text("biblialivre@izaias.dev"),
                ),
            ListTile(
              leading: Icon(Icons.bookmark_border),
              trailing: Icon(Icons.arrow_forward_ios),
              title: Text("Page 1"),
              subtitle: Text("Mais informações"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.pets),
              trailing: Icon(Icons.arrow_forward_ios),
              title: Text("ListView"),
              subtitle: Text("Mais informações"),
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }

  _onDrawerClick(context, Widget page) {
    Navigator.pop(context);
    push(context, page);
  }
}
