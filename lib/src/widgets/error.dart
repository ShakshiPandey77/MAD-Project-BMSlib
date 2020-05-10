import 'package:flutter/material.dart';

class Error extends StatelessWidget {
  final String text;

  const Error({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.red,
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
