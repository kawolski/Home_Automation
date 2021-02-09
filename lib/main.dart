import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:home_automation/models/user.dart';
import 'package:home_automation/screens/wrapper.dart';
import 'package:home_automation/services/auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<CustomUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}

