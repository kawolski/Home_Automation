import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:home_automation/screens/home/home.dart';
import 'package:home_automation/screens/authenticate/authenticate.dart';
import 'package:home_automation/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
