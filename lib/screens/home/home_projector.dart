import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_automation/models/house/house.dart';
import 'package:home_automation/models/house/house_auth.dart';
import 'package:home_automation/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:home_automation/models/user.dart';
import 'package:home_automation/screens/home/user_card.dart';
import 'package:home_automation/models/house/house_auth.dart';

class HomeProjector extends StatefulWidget {
  @override
  _HomeProjectorState createState() => _HomeProjectorState();
}

class _HomeProjectorState extends State<HomeProjector> {
  final AuthService _auth = AuthService();
  String status = 'House Found';

  @override
  Widget build(BuildContext context) {
    final customUser = Provider.of<CustomUser>(context);
    final userData = Provider.of<UserData>(context);

    final _houseAuth = HouseAuth(uid: userData.uid);

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              color: Colors.blue[200],
              child: UserCard(subtext: status)),
        ],
      ),
    );
  }
}
