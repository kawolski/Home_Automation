import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_automation/models/user.dart';
import 'package:home_automation/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //  Create Firebase user based on FirebaseUser 'User'
  CustomUser _userFromFirebaseUser(User user) {
    return user != null ? CustomUser(uid: user.uid) : null;
  }

  //  Auth change user stream
  Stream<CustomUser> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //  SignIn Anon
  Future signInAnon() async {
    try {} catch (e) {
      print(e);
    }
  }

  //  Register with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //  SignIn with email and password
  Future registerWithEmailAndPassword(
      String userName, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      //  Create a new document for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData(userName);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e);
    }
  }

  //  Sign Out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
