import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:carewise/providers/medicine.dart';
import 'package:carewise/providers/medicine_list.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddMedicine extends StatefulWidget {
  static const routeName = '/add-medicine';
  @override
  _AddMedicineState createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  var _isLoading = false;
  final _descriptionFN = FocusNode();
  final _quantityFN = FocusNode();
  final _form = GlobalKey<FormState>();
  TimeOfDay selectedTime;
  var pickedImage;
  var _editedMedicine = Medicine(
      id: null,
      title: '',
      description: '',
      alarmTime: null,
      imageurl: null,
      quantity: 0);

  void _presentTimePicker() {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((pickedTime) {
      if (pickedTime == null) return;

      setState(() {
        selectedTime = pickedTime;
        _editedMedicine = Medicine(
            id: null,
            title: _editedMedicine.title,
            description: _editedMedicine.description,
            alarmTime: selectedTime,
            imageurl: _editedMedicine.imageurl,
            quantity: _editedMedicine.quantity);
      });
    });
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm();
    return format.format(dt);
  }

  StorageReference storageReference = FirebaseStorage.instance.ref();
  void pickImage() async {
    final picker = ImagePicker();
    pickedImage = await picker.getImage(
        source: ImageSource.camera,
        maxHeight: 480,
        maxWidth: 640,
        imageQuality: 50);
    final pickedImageFile = File(pickedImage.path);
    StorageReference ref =
        storageReference.child("gs://${pickedImageFile.toString()}");
    StorageUploadTask uploadTask = ref.putFile(pickedImageFile);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String imageurl = await taskSnapshot.ref.getDownloadURL();
    print(imageurl);
    setState(() {
      pickedImage = pickedImageFile;
      _editedMedicine = Medicine(
          id: null,
          title: _editedMedicine.title,
          description: _editedMedicine.description,
          alarmTime: _editedMedicine.alarmTime,
          imageurl: imageurl,
          quantity: _editedMedicine.quantity);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _descriptionFN.dispose();
    _quantityFN.dispose();
    super.dispose();
  }

  //BUG: validation is not working
  //CHECK: the values get reset to initialized values
  //TRY: try setState
  void _saveForm() {
    setState(() {
      _isLoading = true;
    });
    final _isValid = _form.currentState.validate();
    if (_isValid) {
      _form.currentState.save();
      print(_editedMedicine.alarmTime);
      print(_editedMedicine.title);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Medicine"),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                  key: _form,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          width: double.infinity,
                          height: 80.0,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            icon: Icon(Icons.medical_services),
                            hintText: 'Medicine Name',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 30.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                          ),
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_descriptionFN);
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please enter a name";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            _editedMedicine = Medicine(
                                id: null,
                                title: value,
                                description: _editedMedicine.description,
                                alarmTime: _editedMedicine.alarmTime,
                                imageurl: _editedMedicine.imageurl,
                                quantity: _editedMedicine.quantity);
                          },
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 40.0,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            icon: Icon(Icons.description_rounded),
                            hintText: 'Medicine Description',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 30.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                          ),
                          textInputAction: TextInputAction.next,
                          focusNode: _descriptionFN,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_quantityFN);
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please enter a description";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            _editedMedicine = Medicine(
                                id: null,
                                title: _editedMedicine.title,
                                description: value,
                                alarmTime: _editedMedicine.alarmTime,
                                imageurl: _editedMedicine.imageurl,
                                quantity: _editedMedicine.quantity);
                          },
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 40.0,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            icon: Icon(Icons.dialpad),
                            hintText: 'Medicine Quantity',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 30.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                          ),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          focusNode: _quantityFN,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please enter a number";
                            }
                            if (int.tryParse(value) == null) {
                              return "Please enter a valid number";
                            }
                            if (int.parse(value) <= 0) {
                              return "Please enter a number greater than zero";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            _editedMedicine = Medicine(
                                id: null,
                                title: _editedMedicine.title,
                                description: _editedMedicine.description,
                                alarmTime: _editedMedicine.alarmTime,
                                imageurl: _editedMedicine.imageurl,
                                quantity: int.parse(value));
                          },
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 40.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(selectedTime == null
                                ? "No time selected"
                                : formatTimeOfDay(selectedTime)),
                            FlatButton(
                              onPressed: () {
                                _presentTimePicker();
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
                        SizedBox(
                          width: double.infinity,
                          height: 40.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            CircleAvatar(
                              radius: 40.0,
                              backgroundImage: pickedImage != null
                                  ? NetworkImage(_editedMedicine.imageurl)
                                  : null,
                            ),
                            FlatButton.icon(
                              onPressed: pickImage,
                              icon: Icon(Icons.camera),
                              label: Text("Add an image"),
                            ),
                          ],
                        ),
                        FlatButton(
                          onPressed: () {
                            _saveForm();
                            Provider.of<MedicineList>(context, listen: false)
                                .addItem(_editedMedicine)
                                .catchError((err) {
                              return showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: Text('An error occured'),
                                  content: Text(err.toString()),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text("Ok"),
                                      onPressed: () => Navigator.of(ctx).pop(),
                                    )
                                  ],
                                ),
                              );
                            }).then((_) {
                              setState(() {
                                _isLoading = false;
                              });
                              Navigator.of(context).pop();
                            });
                          },
                          child: Text('Save'),
                          height: 50.0,
                          textColor: Colors.white,
                          color: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0)),
                        ),
                        /*  TextFormField(
                    keyboardType: TextInputType.datetime,
                  ) */
                      ],
                    ),
                  )),
            ),
    );
  }
}
