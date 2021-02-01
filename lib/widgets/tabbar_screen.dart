/* import 'package:CareWise/inventory.dart';
import 'package:CareWise/screens/logbook.dart';*/

import 'package:flutter/material.dart';

import '../screens/medicine_overview.dart';

class TabBarScreen extends StatefulWidget {
  @override
  _TabBarScreenState createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  @override
  Widget build(BuildContext context) {
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
                  FlatButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Morning",
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Icon(Icons.wb_sunny),
                      ],
                    ),
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Afternoon",
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Icon(Icons.wb_sunny_rounded),
                      ],
                    ),
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Evening",
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Icon(Icons.nights_stay),
                      ],
                    ),
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
                Icon(Icons.settings),
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
            /* Inventory(),
            LogBook(), */
          ],
        ),
      ),
    );
  }
}
