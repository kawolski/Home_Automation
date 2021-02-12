import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_automation/models/house/house.dart';
import 'package:home_automation/services/database.dart';

class HouseAuth {
  CollectionReference house = FirebaseFirestore.instance.collection('House');
  CollectionReference user = FirebaseFirestore.instance.collection('Users');
  final String uid;
  String error = '';

  HouseAuth({this.uid});

  bool verifyHouseID(DocumentSnapshot snapshot) {
    // snapshot.data()['House ID']
    String houseIdCheck = snapshot.data()['House ID'];
    if (houseIdCheck == null) {
      error = 'House Not Set';
      return false;
    } else {
      if (house.doc(houseIdCheck) != null) {
        error = '';
        return true;
      } else {
        error = 'Invalid House ID';
        return false;
      }
    }
  }

  Future getMyHouse(String houseName) async {
    dynamic result =
        await user.doc(uid).get(); //then((value) => print(value.data()));
    if (verifyHouseID(result) == false) {
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
      error = 'House Already Built';
      return House(hid: result.data()['House ID'], houseName: houseName);
    }
  }
}
