// import 'package:bmslib/src/widgets/loading/loading.dart';
// import 'package:bmslib/src/models/user.dart';
// import 'package:flutter/material.dart';
// import 'dart:async';

// import 'package:bmslib/src/screens/home/home_screen.dart';
// import 'package:bmslib/src/screens/authenticate/signInSignUp.dart';
// import 'package:provider/provider.dart';

// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();

//     // check if user is already logged in
//     _delay().then((user) {
//       if (user != null) {
//         // signed in
//         print("-> Home");
//         _navigateToHome();
//       } else {
//         // not signed in
//         print("-> Login");
//         _navigateToLogin();
//       }
//     });
//   }

//   Future<dynamic> _delay() async {
//     // waiting for Firebase Auth to initialise here
//     final user = Provider.of<User>(context);
//     await Future.delayed(Duration(milliseconds: 2000), () {});
//     return user;
//     // return await Provider.of<User>(context);
//     // print(user);
//     // if (user == null) {
//     //   // not signed in
//     //   return false;
//     // } else {
//     //   // signed in
//     //   return true;
//     // }
//   }

//   void _navigateToHome() {
//     Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
//   }

//   void _navigateToLogin() {
//     Navigator.of(context).pushReplacement(MaterialPageRoute(
//         builder: (BuildContext context) => LoginSignupPage()));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Loading();
//   }
// }

// // import 'package:bmslib/src/models/user.dart';
// // import 'package:bmslib/src/screens/authenticate/signInSignUp.dart';
// // import 'package:bmslib/src/screens/home/home_screen.dart';
// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';

// // class SplashScreen extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     final user = Provider.of<User>(context);
// //     //print(user);
// //     if (user == null) {
// //       //print("-> Login");
// //       return LoginSignupPage();
// //     } else {
// //       //print("-> Home");
// //       return HomeScreen();
// //     }
// //   }
// // }

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
          return Loading();
        } else if (snapshot.hasData) {
          return HomeScreen();
        } else {
          return LoginSignupPage();
        }
      },
    );
  }
}
