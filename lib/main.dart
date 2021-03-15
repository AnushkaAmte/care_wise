import 'package:carewise/providers/auth.dart';
import 'package:carewise/screens/edit_medicine.dart';
import 'package:carewise/widgets/tabbar_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/login_page.dart';
import 'screens/medicine_detail.dart';
import 'screens/logbook_screen.dart';
import 'screens/inventory.dart';
import 'screens/add_medicine.dart';
import 'providers/medicine_list.dart';
import 'providers/logbook_provider.dart';
import 'providers/inventory_provider.dart';
import 'providers/medicine.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MedicineList(),
        ),
        ChangeNotifierProvider(
          create: (context) => LogBookProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MedicineProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => InventoryProvider(),
        ),
        StreamProvider<FirebaseUser>.value(
          value: FirebaseAuth.instance.onAuthStateChanged,
        ),
        /* ChangeNotifierProvider(
          create: (context) => Auth(),
        ), */
      ],
      child: MaterialApp(
        title: 'CareWise',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
          buttonColor: Color(0xA846A0),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.onAuthStateChanged,
          builder: (ctx, userSnapshot) {
            if (userSnapshot.hasData) {
              return TabBarScreen();
            }
            return LoginPage();
          },
        ),
        routes: {
          MedicineDetail.routeName: (ctx) => MedicineDetail(),
          LogbookScreen.routeName: (ctx) => LogbookScreen(),
          Inventory.routeName: (ctx) => Inventory(),
          AddMedicine.routeName: (ctx) => AddMedicine(),
          EditMedicine.routeName: (ctx) => EditMedicine(),
        },
      ),
    );
  }
}
