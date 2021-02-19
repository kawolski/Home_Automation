import 'package:flutter/material.dart';
import 'package:home_automation/models/house/house.dart';
import 'package:home_automation/models/house/house_auth.dart';
import 'package:home_automation/models/house/no_house.dart';
import 'package:home_automation/models/user.dart';
import 'package:home_automation/screens/home/drawer_functions.dart';
import 'package:home_automation/screens/home/drawer_tile.dart';
import 'package:home_automation/screens/home/home_projector.dart';
import 'package:home_automation/screens/home/select.dart';
import 'package:home_automation/screens/home/user_card.dart';
import 'package:home_automation/screens/settings/settings.dart';
import 'package:home_automation/services/auth.dart';
import 'package:home_automation/services/database.dart';
import 'package:home_automation/shared/loading.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);

    final _houseAuth = HouseAuth(uid: user.uid);
    final DrawerFunctions df = DrawerFunctions();
    bool isHouse = false;

    return StreamProvider<UserData>.value(
      value: DatabaseService(uid: user.uid).userData,
      child: Scaffold(
        backgroundColor: Colors.blue[200],
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
        ),
        body: Select(),
        drawer: Drawer(
          elevation: 1,
          child: ListView(
            padding: EdgeInsets.all(0),
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.lightBlue),
                child: Column(children: <Widget>[
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('assets/stock_profile.png'),
                  ),
                ]),
              ),
              DrawerTile(
                  icon: Icons.add, text: "Add New Device", function: df.test),
              DrawerTile(
                  icon: Icons.settings,
                  text: "Settings",
                  function: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Settings()));
                  }),
              DrawerTile(
                  icon: Icons.perm_identity_rounded,
                  text: "Leave",
                  function: () async {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text("Are You Sure"),
                                SizedBox(height: 20),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    TextButton(
                                      // padding:EdgeInsets.symmetric(horizontal:20),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.black54),
                                      ),
                                      child: Text(
                                        "Yes",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () async {
                                        Navigator.pop(context);
                                        await _auth.signOut();
                                      },
                                    ),
                                    TextButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.black54)),
                                      child: Text(
                                        "No",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
