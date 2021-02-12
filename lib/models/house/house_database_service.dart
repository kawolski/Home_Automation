import 'package:cloud_firestore/cloud_firestore.dart';

class HouseDBS {
  final String hid;

  HouseDBS({this.hid});

  CollectionReference houseCollection =
      FirebaseFirestore.instance.collection('House');

  Future updateHouseData(String hname) async {
    return await houseCollection.doc(hid).set({'House Name': hname});
  }
}
