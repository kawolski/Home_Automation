import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Text("Settings 1"),
          SizedBox(
            height: 20,
          ),
          Text("Settings 2"),
          SizedBox(
            height: 20,
          ),
          Text("Settings 3"),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
