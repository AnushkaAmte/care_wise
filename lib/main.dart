import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/login_page.dart';
import 'screens/medicine_detail.dart';
import 'providers/medicine_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => MedicineList(),
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
        },
      ),
    );
  }
}
