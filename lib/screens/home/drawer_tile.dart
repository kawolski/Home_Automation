import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function function;

  DrawerTile({this.icon, this.text, this.function});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(5, 6, 5, 0),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.black87,
        ),
        title: Text(text,
            style: TextStyle(
              color: Colors.grey,
            )),
        onTap: function,
      ),
    );
  }
}
