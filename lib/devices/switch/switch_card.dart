import 'package:flutter/material.dart';

class SwitchCard extends StatefulWidget {
  final String name;
  final String state;

  SwitchCard({this.name, this.state});

  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<SwitchCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage('assets/stock_profile.png'),
          ),
          title: Text(widget.name),
          subtitle: Text(widget.state),
        ),
      ),
    );
  }
}
