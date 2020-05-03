import 'package:bmslib/src/services/auth.dart';
import 'package:flutter/material.dart';

class IssuerDrawer extends StatelessWidget {
  final AuthService _auth = AuthService();
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
            title: Text('Logout'),
            onTap: () {
              _auth.signOut();
            },
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
