import 'package:bmslib/src/models/user.dart';
import 'package:bmslib/src/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  User _userFromFirebaseUser(FirebaseUser user, bool isAdmin) {
    return user != null ? User(uid: user.uid, isAdmin: isAdmin) : null;
  }

  // auth change user stream
  // Stream<User> get user {
  //   return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  // }

  // return FirebaseAuth object
  FirebaseAuth get getAuth {
    return _auth;
  }

  // get current user
  Future<User> getCurrentUser() async {
    FirebaseUser user = await _auth.currentUser();
    final idTokenResult = await user.getIdToken(refresh: true);
    bool isAdmin = idTokenResult.claims['admin'] ?? false;
    return _userFromFirebaseUser(user, isAdmin);
  }

  // sign in with email, library card number and password
  Future signIn(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      final idTokenResult = await user.getIdToken(refresh: true);
      bool isAdmin = idTokenResult.claims['admin'] ?? false;
      //print(isAdmin);
      return _userFromFirebaseUser(user, isAdmin);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // register a new user
  Future signUp(UserData newUser, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: newUser.email, password: password);
      FirebaseUser user = result.user;
      // create a new document for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData(
        newUser.libid,
        newUser.name,
        newUser.email,
        newUser.phone,
        newUser.borrowed,
        newUser.bag,
      );
      return _userFromFirebaseUser(user, false); // isAdmin is false
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
