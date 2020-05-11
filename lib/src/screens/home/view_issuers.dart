import 'package:bmslib/src/models/book.dart';
import 'package:bmslib/src/models/user.dart';
import 'package:bmslib/src/screens/home/issuer_tile.dart';
import 'package:bmslib/src/screens/home/user_tile.dart';
import 'package:bmslib/src/widgets/empty.dart';
import 'package:bmslib/src/widgets/error.dart';
import 'package:bmslib/src/widgets/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:bmslib/src/services/database.dart';

class ViewIssuers extends StatelessWidget {
  final Book book;

  const ViewIssuers({Key key, this.book}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return (book != null)
        ? FutureBuilder<List<Map<String, dynamic>>>(
            future: DatabaseService().getIssuers(book.uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Loading();
              else if (snapshot.hasError) {
                print(snapshot.error);
                return Error(text: "Something unexpected has occurred :(");
              } else {
                return Scaffold(
                  appBar: AppBar(
                    title: Text('Issuers'),
                  ),
                  body: (snapshot.data.isEmpty)
                      ? emptyWidget("Nothing to see here")
                      : ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return IssuerTile(issuerMap: snapshot.data[index]);
                          },
                        ),
                );
              }
            },
          )
        : StreamBuilder<List<UserData>>(
            stream: DatabaseService().users,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Loading();
              else {
                return Scaffold(
                  appBar: AppBar(
                    title: Text('Issuers'),
                  ),
                  body: (snapshot.data.isEmpty)
                      ? emptyWidget("Nothing to see here")
                      : ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return UserTile(user: snapshot.data[index]);
                          },
                        ),
                );
              }
            });
  }
}
