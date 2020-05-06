import 'package:bmslib/src/widgets/empty.dart';
import 'package:flutter/material.dart';

class MyNotification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Notifications'),
        ),
      ),
      body: emptyWidget(),
    );
  }
}
