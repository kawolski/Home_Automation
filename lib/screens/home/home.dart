import 'package:flutter/material.dart';
import 'package:home_automation/models/user.dart';
import 'package:home_automation/screens/add_devices/add_devices.dart';
import 'package:home_automation/screens/home/drawer_tile.dart';
import 'package:home_automation/screens/home/select.dart';
import 'package:home_automation/screens/settings/settings.dart';
import 'package:home_automation/services/auth.dart';
import 'package:home_automation/services/database.dart';
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

    // final _houseAuth = HouseAuth(uid: user.uid);
    // final DrawerFunctions df = DrawerFunctions();
    // final realDB = RealDeviceData(uid: user.uid);
    // bool isHouse = false;

    return StreamProvider<UserData>.value(
      value: DatabaseService(uid: user.uid).userData,
      child: Scaffold(
        backgroundColor: Colors.blue[200],
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          actions: <Widget>[
            TextButton.icon(
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              ),
              label: Text(
                'Reload',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                setState(() {
                  print('Reloaded');
                });
              },
            )
          ],
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
              //  Add New Device
              DrawerTile(
                  icon: Icons.add,
                  text: "Add New Device",
                  function: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddDevices()));
                  }),
              //  Settings
              DrawerTile(
                  icon: Icons.settings,
                  text: "Settings",
                  function: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Settings()));
                  }),
              //  Logout
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
