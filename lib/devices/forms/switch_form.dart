import 'package:flutter/material.dart';
import 'package:home_automation/devices/realtime_device_data.dart';
import 'package:home_automation/shared/constants.dart';

class SwitchForm extends StatefulWidget {
  final RealDeviceData realDB;
  final String type;

  SwitchForm({this.realDB, this.type});

  @override
  _DevicesState createState() => _DevicesState();
}

class _DevicesState extends State<SwitchForm> {
  final _formkey = GlobalKey<FormState>();

  String lightName = '';
  String location = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            decoration: textInputDecoration.copyWith(hintText: 'Device Name'),
            validator: (val) => val.isEmpty ? 'Please Enter a Name' : null,
            onChanged: (val) {
              setState(() {
                lightName = val;
              });
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: textInputDecoration.copyWith(hintText: 'Location'),
            validator: (val) => val.isEmpty ? 'Please Enter a Location' : null,
            onChanged: (val) {
              setState(() {
                location = val;
              });
            },
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.blue[600]),
            ),
            child: Text('ADD'),
            onPressed: () {
              if (_formkey.currentState.validate()) {
                // widget.realDB.createData(devName);
                widget.realDB.createSwitch(
                    type: widget.type,
                    switchName: lightName,
                    location: location);
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
