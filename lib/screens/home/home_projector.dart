import 'package:flutter/material.dart';
import 'package:home_automation/devices/realtime_device_data.dart';

// import 'package:home_automation/models/house/house_auth.dart';
// import 'package:home_automation/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:home_automation/models/user.dart';

class HomeProjector extends StatefulWidget {
  @override
  _HomeProjectorState createState() => _HomeProjectorState();
}

class _HomeProjectorState extends State<HomeProjector> {
  // final AuthService _auth = AuthService();
  String status = 'House Found';

  void test(bool b) {}

  @override
  Widget build(BuildContext context) {
    // final customUser = Provider.of<CustomUser>(context);
    final userData = Provider.of<UserData>(context);
    // bool devices = false;
    // final _houseAuth = HouseAuth(uid: userData.uid);
    final RealDeviceData realDB = RealDeviceData(uid: userData.uid);
    realDB.loadHID();

    // try{
    //
    // }catch(e){
    //
    // }finally{
    //
    // }
    return ListView(
      children: <Widget>[
        ExpansionTile(
          backgroundColor: Colors.yellowAccent.withOpacity(0.6),
          initiallyExpanded: false,
          title: Text('Light'),
          children: realDB.loadLights(),
        ),
        ExpansionTile(
          initiallyExpanded: false,
          backgroundColor: Colors.deepPurpleAccent.withOpacity(0.6),
          title: Text('Switches'),
          children: realDB.loadSwitches(),
        )
      ],
    );
    // if(realDB.hid == null){
    //   return Center(
    //     child: Container(
    //       child: Text('No Devices'),
    //     ),
    //   );
    // }
    // else{
    //   return ListView(
    //     children: <Widget>[
    //       ExpansionTile(
    //         backgroundColor: Colors.yellowAccent.withOpacity(0.6),
    //         initiallyExpanded: false,
    //         title: Text('Light'),
    //         children: realDB.loadLights(),
    //       ),
    //       ExpansionTile(
    //         initiallyExpanded: false,
    //         backgroundColor: Colors.deepPurpleAccent.withOpacity(0.6),
    //         title: Text('Light'),
    //         children: <Widget>[
    //           SwitchCard(name: "Cooler",state: "false",),
    //           SwitchCard(name: "Water Pump",state: "false",)
    //         ],
    //       )
    //     ],
    //   );
    // }
  }
}

// child: Container(
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// crossAxisAlignment: CrossAxisAlignment.end,
// children: <Widget>[
// Container(
// padding: EdgeInsets.all(10),
// margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
// color: Colors.blue[200],
// child: UserCard(subtext: status)),
// ],
// ),
// ),