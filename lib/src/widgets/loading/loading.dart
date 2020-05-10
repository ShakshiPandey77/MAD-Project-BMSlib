import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300].withOpacity(0.6),
      child: Center(
        child: SpinKitWave(
          color: Colors.blue[200],
        ),
      ),
    );
  }
}
