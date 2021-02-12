import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'file:///L:/Phrontistery/New%20Projs/Home%20IOT/home_automation/lib/models/house/house.dart';
import 'package:home_automation/models/user.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  //  Collection Reference Users
  final CollectionReference users =
      FirebaseFirestore.instance.collection('Users');

  //  Collection Reference House

  //  User Data from Snapshot
  Future updateUserData(String userName) async {
    return await users.doc(uid).set({
      'User Name': userName,
    });
  }

  Future updateUserHouseID(String hid) async {
    print('Updating');
    return await users.doc(uid).update({'House ID': hid});
  }

  //User Data From Snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        userName: snapshot.data()['User Name'],
        hid: snapshot.data()['House ID']);
  }

  //  Get Stream
  Stream<UserData> get userData {
    return users.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
