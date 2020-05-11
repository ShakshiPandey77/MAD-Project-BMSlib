import 'package:bmslib/src/screens/home/bag_tile.dart';
import 'package:bmslib/src/widgets/empty.dart';
import 'package:bmslib/src/widgets/error.dart';
import 'package:bmslib/src/widgets/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:bmslib/src/services/database.dart';

class ViewBag extends StatelessWidget {
  final String uid;

  const ViewBag({Key key, this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: DatabaseService(uid: uid).getBag(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Loading();
        else if (snapshot.hasError) {
          print(snapshot.error);
          return Error(text: "Something unexpected has occurred :(");
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text('Your Bag'),
            ),
            body: (snapshot.data.isEmpty)
                ? emptyWidget("Nothing to see here")
                : ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return BagTile(bagMap: snapshot.data[index]);
                    },
                  ),
          );
        }
      },
    );
  }
}
