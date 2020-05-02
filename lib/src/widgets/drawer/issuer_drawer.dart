import 'package:flutter/material.dart';

class IssuerDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('DrawerHeader'),
            decoration: BoxDecoration(
              color: Colors.blueGrey[100],
            ),
          ),
          ListTile(
            title: Text('Close'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
