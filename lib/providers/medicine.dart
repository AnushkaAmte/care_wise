//import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Medicine with ChangeNotifier {
  String id;
  String title;
  String description;
  TimeOfDay alarmTime;
  var imageurl;
  int quantity;
  bool isTaken;
  bool isMorning;
  bool isAfternoon;
  bool isEvening;
  String userId;

  Medicine({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.alarmTime,
    @required this.imageurl,
    @required this.quantity,
    this.userId,
    this.isTaken = false,
    this.isMorning = false,
    this.isAfternoon = false,
    this.isEvening = false,
  });

  Future<void> updateCount(String id,String token) async {
    final url =
        'https://flutter-carewise-default-rtdb.firebaseio.com/medicines/$id.json?auth=$token';
    try {
      await http.patch(url,
          body: json.encode({
            'quantity': quantity - 1,
          }));
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}

/* class Medicines{
  String id;
  String title;
  String description;
  TimeOfDay alarmTime;
   var imageurl;
  int quantity;
  Medicines({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.alarmTime,
    @required this.imageurl,
    @required this.quantity,
  
  });

  factory  Medicines.fromMap(DocumentSnapshot doc){
  Map data = doc.data;
  return Medicines(
    id: doc.documentID,
    title: data['title'],
    description:data['description'],
    alarmTime: data['alarmTime'],
    imageurl:data['imageurl'],
    quantity:data['quantity']

  );
}
} */

class MedicineProvider with ChangeNotifier {
  final meds = Provider.of<Medicine>(context);

  static BuildContext get context => null;
  double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;
  //for comparing the times
  void toggleMorningStatus() {
    if (toDouble(meds.alarmTime) >= 6.00 && toDouble(meds.alarmTime) < 12.00)
      meds.isMorning = !meds.isMorning;
    notifyListeners();
  }

  void toggleAfternoonStatus() {
    if (toDouble(meds.alarmTime) >= 12.00 && toDouble(meds.alarmTime) < 4.00)
      meds.isAfternoon = !meds.isAfternoon;
    notifyListeners();
  }

  void toggleEveningStatus() {
    if (toDouble(meds.alarmTime) >= 4.00 && toDouble(meds.alarmTime) < 6.00)
      meds.isEvening = !meds.isEvening;
    notifyListeners();
  }
}
