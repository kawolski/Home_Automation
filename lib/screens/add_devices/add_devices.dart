import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_automation/devices/forms/switch_form.dart';
import 'package:home_automation/devices/realtime_device_data.dart';
import 'package:home_automation/models/user.dart';
import 'package:provider/provider.dart';

class AddDevices extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<AddDevices> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);

    final RealDeviceData realDB = RealDeviceData(uid: user.uid);

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 50),
                    color: Colors.yellowAccent.withOpacity(0.4),
                    child: TextButton.icon(
                      icon: Icon(Icons.lightbulb_outline_sharp, size: 50),
                      label: Text("Light"),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                content: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text('Light'),
                                    SizedBox(height: 50),
                                    SwitchForm(
                                      realDB: realDB,
                                      type: 'Light',
                                    )
                                  ],
                                ),
                              );
                            });
                      },
                    )),
              ),
              Expanded(
                flex: 1,
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 50),
                    color: Colors.greenAccent.withOpacity(0.4),
                    child: TextButton.icon(
                        icon: Icon(Icons.swipe, size: 50),
                        label: Text("Switches"),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  content: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text('Switches'),
                                      SizedBox(height: 50),
                                      SwitchForm(
                                        realDB: realDB,
                                        type: 'Switch',
                                      )
                                    ],
                                  ),
                                );
                              });
                        })),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 50),
                    color: Colors.redAccent.withOpacity(0.4),
                    child: TextButton.icon(
                      icon: Icon(Icons.account_tree_sharp, size: 50),
                      label: Text("Sensors"),
                      onPressed: () {
                        AlertDialog(title: Text('Under Construction'));
                      },
                    )),
              ),
              Expanded(
                flex: 1,
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 50),
                    color: Colors.deepPurpleAccent.withOpacity(0.4),
                    child: TextButton.icon(
                      icon: Icon(Icons.photo_camera_front, size: 50),
                      label: Text("Camera"),
                      onPressed: () {
                        AlertDialog(title: Text('Under Construction'));
                      },
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
