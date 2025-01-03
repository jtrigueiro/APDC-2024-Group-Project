import 'package:adc_group_project/services/firestore_database.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:adc_group_project/services/models/user.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create User object based on User
  CustomUser? _userfromFirebaseToCostum(User? user) {
    return user != null ? CustomUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<CustomUser?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userfromFirebaseToCostum(user));
  }

  //sign in with google
  Future signInWithGoogle() async {
    try {
      final GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
      UserCredential result;
      // if sign is through a web browser, else must be throught the mobile app
      if (kIsWeb) {
        result = await _auth.signInWithPopup(googleAuthProvider);
      } else {
        result = await _auth.signInWithProvider(googleAuthProvider);
      }
      User? user = result.user;
      await DatabaseService().createOrOverwriteUserData(
          user!.uid, user.displayName!, await DatabaseService().isAdmin());
      return _userfromFirebaseToCostum(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email & password
  Future signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userfromFirebaseToCostum(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email & password
  Future registerWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      //await user!.sendEmailVerification();
      //create a new document for the user with the uid
      await DatabaseService().createOrOverwriteUserData(user!.uid, name, false);
      return _userfromFirebaseToCostum(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // TODO: reset password
}
