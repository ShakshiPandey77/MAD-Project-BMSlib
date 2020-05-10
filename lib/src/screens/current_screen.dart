import 'package:bmslib/src/screens/authenticate/signInSignUp.dart';
import 'package:bmslib/src/screens/home/home_screen.dart';
import 'package:bmslib/src/services/auth.dart';
import 'package:bmslib/src/widgets/loading/loading.dart';
import 'package:flutter/material.dart';

class CurrentScreen extends StatelessWidget {
  final AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    // listens to firebase auth stream and returns the appropriate screen
    return StreamBuilder(
      stream: authService.getAuth.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          print("waiting...");
          return Loading();
        } else if (snapshot.hasData) {
          //print(snapshot.data['uid']);
          print("-> Home");
          return HomeScreen();
        } else {
          print("-> Login");
          return LoginSignupPage();
        }
      },
    );
  }
}
