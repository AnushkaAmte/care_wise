import 'package:carewise/screens/edit_medicine.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/medicine_list.dart';

class MedicineDetail extends StatefulWidget {
  static const routeName = '/medicine-detail';

  @override
  _MedicineDetailState createState() => _MedicineDetailState();
}

class _MedicineDetailState extends State<MedicineDetail> {
  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm();
    return format.format(dt);
  }

  /*@override
   void initState() {
    Future.delayed(Duration.zero).then((_) {
      Navigator.of(context).pop();
    });
    super.initState();
  } */

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
            onPressed: () {
              Navigator.of(context).pushNamed(EditMedicine.routeName,
                  arguments: loadedMedicine.id);
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              try {
                await Provider.of<MedicineList>(context, listen: false)
                    .deleteItem(loadedMedicine.id);
              } catch (error) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Deleting failed'),
                  ),
                );
              }
              Navigator.of(context)
                  .pop(); //TRY: put this in a initstate or a didchangedependencies
            },
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
            TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                helperText: 'Medicine Name',
                hintText: loadedMedicine.title,
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
            TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                hintText: loadedMedicine.description,
                helperText: 'Description',
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
              readOnly: true,
              decoration: InputDecoration(
                hintText: formatTimeOfDay(loadedMedicine.alarmTime),
                helperText: 'Alarm Time',
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
              readOnly: true,
              decoration: InputDecoration(
                hintText: loadedMedicine.quantity.toString(),
                helperText: 'Quantity',
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
