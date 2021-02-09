import 'package:flutter/material.dart';
import 'package:home_automation/models/user.dart';
import 'package:provider/provider.dart';

class UserCard extends StatefulWidget {
  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    final data =
        Provider.of<UserData>(context) ?? UserData(uid: '??', userName: '??');

    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage('assets/stock_profile.png'),
          ),
          title: Text(data.userName ?? ''),
          subtitle: Text('Working on details'),
        ),
      ),
    );
  }
}
