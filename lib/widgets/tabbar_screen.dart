import 'package:carewise/providers/auth.dart';
import 'package:carewise/screens/auth_screen.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:provider/provider.dart';

import '../screens/medicine_overview.dart';
import '../screens/inventory.dart';
import '../screens/logbook_screen.dart';

class TabBarScreen extends StatefulWidget {
  
  @override
  _TabBarScreenState createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  @override
  Widget build(BuildContext context) {
    //final medicineData = Provider.of<MedicineList>(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              Container(
                height: 50.0,
              ),
              CircleAvatar(
                radius: 60.0,
                backgroundColor: Colors.black,
                backgroundImage: NetworkImage(
                    'https://image.shutterstock.com/image-vector/user-login-authenticate-icon-human-260nw-1365533969.jpg'),
              ),
              Text(
                'User Name',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Text(''),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SwitchListTile(
                    onChanged: (bool v) {},
                    value: false,
                    title: const Text("Morning"),
                    secondary: Icon(Icons.wb_sunny),
                  ),
                  SwitchListTile(
                    onChanged: (bool v) {},
                    value: false,
                    title: const Text("Afternoon"),
                    secondary: Icon(Icons.wb_sunny),
                  ),
                  SwitchListTile(
                    onChanged: (bool v) {},
                    value: false,
                    title: const Text("Evening"),
                    secondary: Icon(Icons.nightlight_round),
                  ),
                ],
              )
            ],
          ),
        ),
        appBar: AppBar(
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: <Widget>[
                IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () {
                    Provider.of<Auth>(context, listen: false).logout();
                    //Navigator.of(context).pop();
                    Navigator.of(context)
                        .pushReplacementNamed(AuthScreen.routeName);
                  },
                ),
              ]),
            ),
          ],
          title: Text('CareWise'),
          bottom: TabBar(
            tabs: [
              Tab(
                  child: Text(
                'List',
                style: TextStyle(fontSize: 20.0),
              )),
              Tab(
                  child: Text(
                'Inventory',
                style: TextStyle(fontSize: 20.0),
              )),
              Tab(
                  child: Text(
                'Med Log',
                style: TextStyle(fontSize: 20.0),
              )),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            MedicineOverview(),
            Inventory(),
            LogbookScreen(),
          ],
        ),
      ),
    );
  }
}
