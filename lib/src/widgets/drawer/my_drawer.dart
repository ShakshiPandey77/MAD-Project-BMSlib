//import 'package:bmslib/src/services/auth.dart';
import 'package:bmslib/src/models/user.dart';
import 'package:bmslib/src/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:bmslib/src/services/database.dart';

class MyDrawer extends StatelessWidget {
  final AuthService _auth = AuthService();
  final User currentUser;
  MyDrawer({this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              "Shehyaaz", // from database
              style: TextStyle(fontSize: 22),
            ),
            accountEmail: Text("shehyaaz.cs17@bmsce.ac.in"), // from database
            currentAccountPicture: CircleAvatar(
              // backgroundColor: Colors.transparent,
              radius: 28.0,
              child: Image.asset(
                  'assets/images/account.png'), // first letter of user name
            ),
            decoration: BoxDecoration(
              color: Colors.blue[600],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text(
              'Home',
              style: TextStyle(fontSize: 14),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          (currentUser.isAdmin)
              ? ListTile(
                  title: Text(
                    'Issuers',
                    style: TextStyle(fontSize: 14),
                  ),
                  leading: Icon(Icons.people),
                  onTap: () {
                    Navigator.pop(context);
                  },
                )
              : Container(),
          ListTile(
            title: Text(
              'My Bag',
              style: TextStyle(fontSize: 14),
            ),
            leading: Icon(Icons.account_balance_wallet),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(
              'My Account',
              style: TextStyle(fontSize: 14),
            ),
            leading: Icon(Icons.person),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(
              'Logout',
              style: TextStyle(fontSize: 14),
            ),
            leading: Icon(Icons.exit_to_app),
            onTap: () {
              Navigator.pop(context);
              _auth.signOut();
            },
          ),
          Divider(
            color: Colors.grey[500],
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 15),
            title: Text(
              'Close',
              style: TextStyle(fontSize: 14),
            ),
            leading: Icon(Icons.cancel),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}