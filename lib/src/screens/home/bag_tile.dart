import 'package:flutter/material.dart';
import 'package:bmslib/src/models/user.dart';

class BagTile extends StatelessWidget {
  final Map<String, dynamic> bagMap;

  BagTile({this.bagMap});

  @override
  Widget build(BuildContext context) {
    Bag bagItem = Bag.fromMap(bagMap);
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage("assets/images/book_avatar.png"),
          ),
          title: Text(
            bagItem.bookTitle,
            style: Theme.of(context).textTheme.title.copyWith(
                  fontSize: 16.0,
                  color: Theme.of(context).textTheme.title.color,
                ),
          ),
          subtitle: Text(
            "Issued : ${bagItem.issueDate}\nReturn : ${bagItem.returnDate}",
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
