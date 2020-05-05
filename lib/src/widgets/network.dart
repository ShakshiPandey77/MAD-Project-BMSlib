import 'package:bmslib/src/services/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NetworkWidget extends StatelessWidget {
  const NetworkWidget({
    Key key,
    this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    var network = Provider.of<ConnectionStatus>(context);
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    if (network == ConnectionStatus.wifi ||
        network == ConnectionStatus.mobileData) {
      print("Connected to network");
      return Container(
        child: child,
      );
    }
    print("Not connected :(");

    return Container(
      color: Colors.white,
      height: _height,
      width: _width,
      child: Image.asset("assets/images/no_network.gif"),
    );
  }
}
