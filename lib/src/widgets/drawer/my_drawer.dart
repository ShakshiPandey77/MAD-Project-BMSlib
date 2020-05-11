import 'package:bmslib/src/models/notifiers/theme_notifier.dart';
import 'package:bmslib/src/screens/home/view_bag.dart';
import 'package:bmslib/src/screens/home/view_issuers.dart';
import 'package:bmslib/src/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  final AuthService _auth = AuthService();

  final String uid;
  final String username;
  final String userEmail;
  final bool isAdmin;

  MyDrawer({
    Key key,
    @required this.uid,
    @required this.username,
    @required this.userEmail,
    @required this.isAdmin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              // displays first name only
              username.split(' ')[0], // from database
              style: TextStyle(fontSize: 22),
            ),
            accountEmail: Text(userEmail), // from database
            currentAccountPicture: CircleAvatar(
              backgroundColor: themeNotifier.darkModeEnabled
                  ? Color(0xFF2657C9)
                  : Color(0xFF396CE3),
              radius: 28.0,
              child: Center(
                child: Text(
                  username.substring(0, 1).toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32.0,
                  ),
                ),
              ), // first letter of user name
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/drawer.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text(
              'Home',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            onTap: () {
              Navigator.pop(context); // remain on home screen
            },
          ),
          (isAdmin)
              ? ListTile(
                  title: Text(
                    'Issuers',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  leading: Icon(Icons.people),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ViewIssuers(),
                      ),
                    );
                  },
                )
              : Container(),
          ListTile(
            title: Text(
              'My Bag',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            leading: Icon(Icons.account_balance_wallet),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ViewBag(uid: uid),
                ),
              );
            },
          ),
          ListTile(
            title: Text(
              'My Account',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            leading: Icon(Icons.person),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(
              'Logout',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
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
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
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
