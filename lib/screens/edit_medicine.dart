import 'package:carewise/providers/medicine.dart';
import 'package:carewise/widgets/tabbar_screen.dart';
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
  //var _isLoading = false;
  final _form = GlobalKey<FormState>();

  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm();
    return format.format(dt);
  }

  var _editedMedicine = Medicine(
      id: null,
      title: '',
      description: '',
      quantity: 0,
      alarmTime: null,
      imageurl: '');

  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'alarmTime': '',
  };

  @override
  void didChangeDependencies() {
    final medID = ModalRoute.of(context).settings.arguments as String;
    if (medID != null) {
      _editedMedicine = Provider.of<MedicineList>(context).findById(medID);
      _initValues = {
        'title': _editedMedicine.title,
        'description': _editedMedicine.description,
        'quantity': _editedMedicine.quantity.toString(),
        'imageUrl': _editedMedicine.imageurl,
        'alarmTime': formatTimeOfDay(_editedMedicine.alarmTime),
      };
    }
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  void _saveForm() {
    _form.currentState.save();
    if (_editedMedicine.id != null) {
      Provider.of<MedicineList>(context, listen: false)
          .editAndSetMedicines(_editedMedicine.id, _editedMedicine);
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TabBarScreen()),
    );
  }

  void _presentTimePicker() {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((pickedTime) {
      if (pickedTime == null) return;

      setState(() {
        _selectedTime = pickedTime;
        _editedMedicine = Medicine(
            id: _editedMedicine.id,
            title: _editedMedicine.title,
            description: _editedMedicine.description,
            alarmTime: _selectedTime,
            imageurl: _editedMedicine.imageurl,
            quantity: _editedMedicine.quantity);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_initValues['title']),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save_rounded),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10.0),
                height: 250,
                child: Image(
                  image: NetworkImage(_editedMedicine.imageurl),
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
                initialValue: _initValues['title'],
                decoration: InputDecoration(
                  helperText: 'Medicine Name',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                ),
                style: TextStyle(fontSize: 20),
                onSaved: (value) {
                  _editedMedicine = Medicine(
                      id: _editedMedicine.id,
                      title: value,
                      description: _editedMedicine.description,
                      alarmTime: _editedMedicine.alarmTime,
                      imageurl: _editedMedicine.imageurl,
                      quantity: _editedMedicine.quantity);
                },
              ),
              SizedBox(
                width: double.infinity,
                height: 20,
              ),
              TextFormField(
                initialValue: _initValues['description'],
                decoration: InputDecoration(
                  helperText: 'Description',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                ),
                style: TextStyle(fontSize: 20),
                onSaved: (value) {
                  _editedMedicine = Medicine(
                      id: _editedMedicine.id,
                      title: _editedMedicine.title,
                      description: value,
                      alarmTime: _editedMedicine.alarmTime,
                      imageurl: _editedMedicine.imageurl,
                      quantity: _editedMedicine.quantity);
                },
              ),
              SizedBox(
                width: double.infinity,
                height: 20,
              ),
              TextFormField(
                initialValue: _initValues['quantity'],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  helperText: 'Quantity',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                ),
                style: TextStyle(fontSize: 20),
                onSaved: (value) {
                  _editedMedicine = Medicine(
                      id: _editedMedicine.id,
                      title: _editedMedicine.title,
                      description: _editedMedicine.description,
                      alarmTime: _editedMedicine.alarmTime,
                      imageurl: _editedMedicine.imageurl,
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
                      ? formatTimeOfDay(_editedMedicine.alarmTime)
                      : formatTimeOfDay(_selectedTime)),
                  FlatButton(
                    onPressed: _presentTimePicker,
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
      ),
    );
  }
}
