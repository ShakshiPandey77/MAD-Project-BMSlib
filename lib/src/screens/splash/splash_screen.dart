import 'package:bmslib/src/widgets/loading/loading.dart';
import 'package:bmslib/src/models/user.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:bmslib/src/screens/home/home_screen.dart';
import 'package:bmslib/src/screens/authenticate/signInSignUp.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // check if user is already logged in
    _displayScreen().then((status) {
      final user = Provider.of<User>(context);
      if (user == null) {
        // not signed in
        _navigateToLogin();
      } else {
        // signed in
        _navigateToHome();
      }
    });
  }

  Future<bool> _displayScreen() async {
    await Future.delayed(Duration(milliseconds: 3000), () {});

    return true;
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
  }

  void _navigateToLogin() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => LoginSignupPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Loading();
  }
}
