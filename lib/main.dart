import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/login_page.dart';
import 'screens/medicine_detail.dart';
import 'screens/logbook_screen.dart';
import 'providers/medicine_list.dart';
import 'providers/logbook_provider.dart';

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
        )
      ],
      child: MaterialApp(
        title: 'CareWise',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
          buttonColor: Color(0xA846A0),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoginPage(),
        routes: {
          MedicineDetail.routeName: (ctx) => MedicineDetail(),
          LogbookScreen.routeName: (ctx) => LogbookScreen(),
        },
      ),
    );
  }
}
