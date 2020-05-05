import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.4),
      child: Center(
        child: SpinKitRotatingCircle(
          color: Colors.blueAccent,
          size: 50.0,
        ),
      ),
    );
  }
}
