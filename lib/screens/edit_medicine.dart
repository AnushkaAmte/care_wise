import 'package:carewise/providers/medicine.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/medicine_list.dart';

class EditMedicine extends StatefulWidget {
  static const routeName = '/editMedicine';
  @override
  _EditMedicineState createState() => _EditMedicineState();
}

class _EditMedicineState extends State<EditMedicine> {
  TimeOfDay _selectedTime;
  var _isLoading = false;
  final _form = GlobalKey<FormState>();

  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm();
    return format.format(dt);
  }

  /* void _presentTimePicker() {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((pickedTime) {
      if (pickedTime == null) return;

      setState(() {
        _selectedTime = pickedTime;
        _editedMedicine = Medicine(
            id: null,
            title: _editedMedicine.title,
            description: _editedMedicine.description,
            alarmTime: _selectedTime,
            imageurl: _editedMedicine.imageurl,
            quantity: _editedMedicine.quantity);
      });
    });
  } */

  void _saveForm() {
    setState(() {
      _isLoading = true;
    });
    _form.currentState.save();
  }

  @override
  Widget build(BuildContext context) {
    final medicineId = ModalRoute.of(context).settings.arguments as String;
    final loadedMedicine =
        Provider.of<MedicineList>(context).findById(medicineId);

    var _editedMedicine = Medicine(
        id: loadedMedicine.id,
        title: loadedMedicine.title,
        description: loadedMedicine.description,
        quantity: loadedMedicine.quantity,
        alarmTime: loadedMedicine.alarmTime,
        imageurl: loadedMedicine.imageurl);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedMedicine.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save_rounded),
            onPressed: () {
              _saveForm();
              Provider.of<MedicineList>(context, listen: false)
                  .editAndSetMedicines(loadedMedicine.id, _editedMedicine);

              setState(() {
                _isLoading = false;
              });
              _isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Navigator.of(context).pop();
            },
          ),
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
              decoration: InputDecoration(
                helperText: 'Medicine Name',
                hintText: loadedMedicine.title,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0)),
              ),
              style: TextStyle(fontSize: 20),
              onSaved: (value) {
                _editedMedicine = Medicine(
                    id: loadedMedicine.id,
                    title: value,
                    description: loadedMedicine.description,
                    alarmTime: loadedMedicine.alarmTime,
                    imageurl: loadedMedicine.imageurl,
                    quantity: loadedMedicine.quantity);
              },
            ),
            SizedBox(
              width: double.infinity,
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: loadedMedicine.description,
                helperText: 'Description',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0)),
              ),
              style: TextStyle(fontSize: 20),
              onSaved: (value) {
                _editedMedicine = Medicine(
                    id: loadedMedicine.id,
                    title: loadedMedicine.title,
                    description: value,
                    alarmTime: loadedMedicine.alarmTime,
                    imageurl: loadedMedicine.imageurl,
                    quantity: loadedMedicine.quantity);
              },
            ),
            SizedBox(
              width: double.infinity,
              height: 20,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: loadedMedicine.quantity.toString(),
                helperText: 'Quantity',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0)),
              ),
              style: TextStyle(fontSize: 20),
              onSaved: (value) {
                _editedMedicine = Medicine(
                    id: loadedMedicine.id,
                    title: loadedMedicine.title,
                    description: loadedMedicine.description,
                    alarmTime: loadedMedicine.alarmTime,
                    imageurl: loadedMedicine.imageurl,
                    quantity: int.parse(value));
              },
            ),
            SizedBox(
              width: double.infinity,
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(_selectedTime == null
                    ? formatTimeOfDay(loadedMedicine.alarmTime)
                    : formatTimeOfDay(_selectedTime)),
                FlatButton(
                  onPressed: () {
                    showTimePicker(
                            context: context, initialTime: TimeOfDay.now())
                        .then((pickedTime) {
                      if (pickedTime == null) return;

                      setState(() {
                        _selectedTime = pickedTime;
                        _editedMedicine = Medicine(
                            id: loadedMedicine.id,
                            title: loadedMedicine.title,
                            description: loadedMedicine.description,
                            alarmTime: _selectedTime,
                            imageurl: loadedMedicine.imageurl,
                            quantity: loadedMedicine.quantity);
                      });
                    });

                    // ignore: unnecessary_statements
                  },
                  child: Text("Select Time"),
                  textColor: Colors.white,
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0)),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
