import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:home_automation/devices/switch/switch_card.dart';

class RealDeviceData {
  final String uid;
  final realDB = FirebaseDatabase.instance.reference();
  CollectionReference user = FirebaseFirestore.instance.collection("Users");

  RealDeviceData({this.uid});

  String hid;

  Future<bool> loadHID() async {
    // dynamic result = await user.doc(uid).get();//.data()['House ID'];
    try {
      dynamic result = await user.doc(uid).get();
      hid = result.data()['House ID'];
      print('Got House ID');
      return true;
    } catch (e) {
      return false;
    }
  }

  void createData(String devName) async {
    dynamic snapshot = await user.doc(uid).get();
    hid = snapshot.data()['House ID'];
    realDB.child(hid).child(devName).set({'type': 'bool', 'state': 'active'});
  }

  void createSwitch(
      {String switchName,
      String location,
      String state = 'false',
      String type}) async {
    dynamic snapshot = await user.doc(uid).get();
    hid = snapshot.data()['House ID'];
    realDB
        .child(hid)
        .child(type)
        .child(switchName)
        .set({'Location': location, 'State': state});
  }

  List<Widget> loadLights() {
    List<Widget> list = [];
    realDB.once().then((DataSnapshot snapshot) {
      // print('Data : ${snapshot.value}');
      // print('Extracting : ${snapshot.value[hid]['Light']}');
      // print('HID : $hid');
      Map map = snapshot.value[hid]['Light'];
      // print('List : $map');
      print("Play");
      map.forEach((name, value) {
        list.add(SwitchCard(name: name, state: value['State']));
        // print('key : $key');
        // print('value : $value');
        // print('value["State"] : ${value['State']}');
      });
    });
    return list;
  }

  List<Widget> loadSwitches() {
    List<Widget> list = [];
    realDB.once().then((DataSnapshot snapshot) {
      // print('Data : ${snapshot.value}');
      // print('Extracting : ${snapshot.value[hid]['Light']}');
      // print('HID : $hid');
      Map map = snapshot.value[hid]['Switch'];
      // print('List : $map');
      print("Play");
      map.forEach((name, value) {
        list.add(SwitchCard(name: name, state: value['State']));
        // print('key : $key');
        // print('value : $value');
        // print('value["State"] : ${value['State']}');
      });
    });
    return list;
  }
}
