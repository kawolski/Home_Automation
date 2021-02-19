import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_automation/models/house/house.dart';
import 'package:home_automation/services/database.dart';

class HouseAuth {
  CollectionReference house = FirebaseFirestore.instance.collection('House');
  CollectionReference user = FirebaseFirestore.instance.collection('Users');
  final String uid;
  String error = '';

  HouseAuth({this.uid});

  Future<bool> verifyHouseID(DocumentSnapshot snapshot) async {
    // snapshot.data()['House ID']
    String houseIdCheck = snapshot.data()['House ID'];
    if (houseIdCheck == null) {
      error = 'House Not Set';
      return false;
    } else {
      dynamic validity = await house.doc(houseIdCheck).get();
      if (validity.data() != null) {
        error = '';
        print(houseIdCheck);
        print(validity.data());
        return true;
      } else {
        error = 'Invalid House ID';
        print(houseIdCheck);
        print(validity.data());
        return false;
      }
    }
  }

  Future<House> checkHouseID(String uid) async {
    dynamic snapshot = await user.doc(uid).get();

    String houseId = snapshot.data()['House ID'];
    if (houseId == null) {
      error = 'House Not Set';
      return null;
    } else {
      dynamic houseSnap = await house.doc(houseId).get();
      if (houseSnap.data() != null) {
        error = 'Building House';
        print(houseId);
        print(houseSnap.data());
        return House(hid: houseId, houseName: houseSnap.data()['House Name']);
      } else {
        error = 'Invalid House ID';
        return null;
      }
    }
  }

  Future getMyHouse(String houseName) async {
    dynamic isHouse = await checkHouseID(uid);
    print(error);
    if (isHouse == null) {
      //  Make New House
      try {
        dynamic result = await house.add({
          'House Name': houseName,
        });
        DatabaseService(uid: uid).updateUserHouseID(result.id);
        return House(hid: result.id, houseName: houseName);
      } catch (err) {
        error = err.toString();
        print(error);
        return null;
      }
    } else {
      //  Return House Data
      error = 'House Already Built -- One House Per User';
      return isHouse;
    }
  }

  House _houseDataFromSnapshot(DocumentSnapshot snapshot) {
    return House(
        hid: snapshot.data()['hid'], houseName: snapshot.data()['House Name']);
  }

  Stream<House> get userHouseData {
    return house.doc(uid).snapshots().map(_houseDataFromSnapshot);
  }
}
