import 'package:flutter/material.dart';
import 'package:home_automation/models/house/house.dart';
import 'package:home_automation/models/house/house_auth.dart';
import 'package:home_automation/models/user.dart';
import 'package:home_automation/screens/home/user_card.dart';
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
  String status = 'Under Construction';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);

    return StreamProvider<UserData>.value(
      value: DatabaseService(uid: user.uid).userData,
      child: loading
          ? Loading()
          : Scaffold(
              backgroundColor: Colors.blue[100],
              appBar: AppBar(
                actions: <Widget>[
                  TextButton.icon(
                    icon: Icon(
                      Icons.cancel,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Logout',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      await _auth.signOut();
                    },
                  ),
                ],
              ),
              body: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.all(10),
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        color: Colors.blue[200],
                        child: UserCard(subtext: status))
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.add,
                  color: Colors.blue,
                ),
                onPressed: () async {
                  setState(() {
                    loading = true;
                  });
                  House result =
                      await HouseAuth(uid: user.uid).getMyHouse("Demo House");
                  if (result == null) {
                    print('Error Loading');
                  } else {
                    print('Got Results');
                    print(result);
                    setState(() {
                      status = result.hid;
                    });
                  }
                  setState(() {
                    loading = false;
                  });
                },
              ),
            ),
    );
  }
}
