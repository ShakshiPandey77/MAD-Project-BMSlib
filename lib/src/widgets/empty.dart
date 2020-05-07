import 'package:flutter/material.dart';

Widget emptyWidget(String msg) {
  return SizedBox.expand(
    child: Center(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/empty.png"),
            fit: BoxFit.contain,
          ),
        ),
        child: Center(
          child: Text(
            msg,
            style: TextStyle(
              fontSize: 36,
            ),
          ),
        ),
      ),
    ),
  );
}
