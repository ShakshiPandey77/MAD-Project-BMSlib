import 'package:flutter/material.dart';
import 'package:bmslib/src/models/book.dart';

class IssuerTile extends StatelessWidget {
  final Map<String, dynamic> issuerMap;

  IssuerTile({this.issuerMap});

  @override
  Widget build(BuildContext context) {
    Issuers issuer = Issuers.fromMap(issuerMap);
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage("assets/images/avatar.png"),
          ),
          title: Text(
            issuer.issuerLibID,
            style: Theme.of(context).textTheme.title.copyWith(
                  fontSize: 16.0,
                  color: Theme.of(context).textTheme.title.color,
                ),
          ),
          subtitle: Text(
            "Issued : ${issuer.issueDate}\nReturn : ${issuer.returnDate}",
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
