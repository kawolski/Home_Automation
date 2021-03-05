import 'package:flutter/material.dart';
import 'package:home_automation/models/house/house.dart';
import 'package:home_automation/models/house/house_auth.dart';
import 'package:home_automation/models/user.dart';
import 'package:home_automation/shared/constants.dart';
import 'package:provider/provider.dart';

class NoHouse extends StatefulWidget {
  @override
  _NoHouseState createState() => _NoHouseState();
}

class _NoHouseState extends State<NoHouse> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context) ??
        UserData(uid: null, userName: null, hid: null);
    String uName = user.userName ?? " ";

    final String message = 'Hi, ${uName.split(" ")[0]}. Let\'s get Started';
    final _houseAuth = HouseAuth(uid: user.uid);
    final _formkey = GlobalKey<FormState>();
    String hName = '';
    String hID = '';

    void loadHouse() async {
      if (hID != null) {
        print('sharing house');
        House result = await _houseAuth.shareHouse(hID);
        print(result);
      } else {
        House result = await _houseAuth.getMyHouse(hName);
        if (result == null) {
          print('Error Loading');
        } else {
          print('Got Results');
          print(result);
        }
      }
    }

    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextButton.icon(
              label: Text(message, style: TextStyle(color: Colors.white)),
              icon: Icon(Icons.house, color: Colors.white, size: 40),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        content: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text('Awaken Your House'),
                            SizedBox(
                              height: 50,
                            ),
                            Form(
                              key: _formkey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  TextFormField(
                                    decoration: textInputDecoration.copyWith(
                                        hintText: 'House Name'),
                                    validator: (val) => val.isEmpty
                                        ? 'Please Enter a Name'
                                        : null,
                                    onChanged: (val) {
                                      setState(() {
                                        hName = val;
                                      });
                                    },
                                  ),
                                  SizedBox(height: 20),
                                  Text("OR"),
                                  SizedBox(height: 20),
                                  TextFormField(
                                    decoration: textInputDecoration.copyWith(
                                        hintText: 'House ID'),
                                    validator: (val) => val.isEmpty
                                        ? 'Please Enter a Name'
                                        : null,
                                    onChanged: (val) {
                                      setState(() {
                                        hID = val;
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.blue[600]),
                                    ),
                                    child: Text('Awaken'),
                                    onPressed: () {
                                      // if (_formkey.currentState.validate()) {
                                      loadHouse();
                                      Navigator.pop(context);
                                      // }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
