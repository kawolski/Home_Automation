import 'package:flutter/material.dart';
import 'package:home_automation/models/house/no_house.dart';
import 'package:home_automation/models/user.dart';
import 'package:home_automation/screens/home/home_projector.dart';
import 'package:provider/provider.dart';

class Select extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context) ??
        UserData(uid: null, userName: null, hid: null);
    if (userData.hid == null) {
      return NoHouse();
    } else {
      return HomeProjector();
    }
  }
}
