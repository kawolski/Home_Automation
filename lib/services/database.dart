import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_automation/models/user.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  //  Collection Reference
  final CollectionReference users =
      FirebaseFirestore.instance.collection('Users');

  //  User Data from Snapshot
  Future updateUserData(String userName) async {
    return await users.doc(uid).set({
      'User Name': userName,
    });
  }

  //User Data From Snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(uid: uid, userName: snapshot.data()['User Name']);
  }

  //  Get Stream
  Stream<UserData> get userData {
    return users.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
