import 'package:flutter/material.dart';

Widget emptyWidget() {
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/images/empty.png"),
        fit: BoxFit.cover,
      ),
    ),
    child: Text(
      "Nothing to see here",
      style: TextStyle(
        color: Colors.grey[800],
      ),
    ) /* add child content here */,
  );
}
