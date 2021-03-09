import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/medicine_list.dart';

class MedicineDetail extends StatelessWidget {
  static const routeName = '/medicine-detail';
  @override
  Widget build(BuildContext context) {
    final medicineId = ModalRoute.of(context).settings.arguments as String;
    final loadedMedicine =
        Provider.of<MedicineList>(context).findById(medicineId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedMedicine.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10.0),
              height: 250,
              child: Image(
                image: NetworkImage(loadedMedicine.imageurl),
                width: double.infinity,
                height: 40,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(
                helperText: loadedMedicine.title,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0)),
              ),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              width: double.infinity,
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(
                helperText: loadedMedicine.description,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0)),
              ),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              width: double.infinity,
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(
                helperText: loadedMedicine.alarmTime.toString(),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0)),
              ),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              width: double.infinity,
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(
                helperText: loadedMedicine.quantity.toString(),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0)),
              ),
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
