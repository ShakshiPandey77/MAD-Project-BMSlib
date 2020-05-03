import 'package:bmslib/src/widgets/loading/loading.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:bmslib/src/screens/home/home_screen.dart';
import 'package:bmslib/src/screens/authenticate/signin.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // check if user is already logged in
    _mockCheckForSession().then((status) {
      if (status) {
        _navigateToHome();
      } else {
        _navigateToLogin();
      }
    });
  }

  Future<bool> _mockCheckForSession() async {
    await Future.delayed(Duration(milliseconds: 3000), () {});

    return true;
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
  }

  void _navigateToLogin() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => null));
  }

  @override
  Widget build(BuildContext context) {
    return Loading();
  }
}

// wrapper.dart
// import 'package:brew_crew/models/user.dart';
// import 'package:brew_crew/screens/authenticate/authenticate.dart';
// import 'package:brew_crew/screens/home/home.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class Wrapper extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {

//     final user = Provider.of<User>(context);

//     // return either the Home or Authenticate widget
//     if (user == null){
//       return Authenticate();
//     } else {
//       return Home();
//     }

//   }
// }
