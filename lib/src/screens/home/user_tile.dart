import 'package:flutter/material.dart';
import 'package:bmslib/src/models/user.dart';

class UserTile extends StatelessWidget {
  final UserData user;

  const UserTile({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage("assets/images/avatar.png"),
          ),
          title: Text(
            user.name,
            style: Theme.of(context).textTheme.subtitle.copyWith(
                  fontSize: 16.0,
                  color: Theme.of(context).textTheme.title.color,
                ),
          ),
          subtitle: Text(
            "Library ID : ${user.libid}\nEmail : ${user.email}\nPhone : ${user.phone}\nBorrowed : ${user.borrowed}",
            style: Theme.of(context).textTheme.subtitle.copyWith(
                  fontSize: 14.0,
                  color: Theme.of(context).textTheme.title.color,
                ),
          ),
        ),
      ),
    );
  }
}
