import 'dart:convert';

import '../models/custom_exceptions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import './medicine.dart';

//TODO: convert this list into a firestore map
//TODO: create a default grid item with intial values
class MedicineList with ChangeNotifier {
  List<Medicine> _items = [
    /* Medicine(
      id: 'm1',
      title: 'Jalra M 1000/50',
      description: 'Diabetes',
      alarmTime: TimeOfDay(hour: 12, minute: 30),
      /* imageurl:
          "data:image/jpeg;base64,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", */
      imageurl: null,
      quantity: 25,
      /* isMorning: false,
      isAfternoon: true,
      isEvening: false, */
    ),
    Medicine(
      id: 'm2',
      title: 'Metorol AM 50',
      description: 'Blood pressure',
      alarmTime: TimeOfDay(hour: 20, minute: 30),
      /*  imageurl:
          "data:image/jpeg;base64,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", */
      imageurl: null,
      quantity: 40,
      /* isMorning: false,
      isAfternoon: false,
      isEvening: true, */
    ),
    Medicine(
      id: 'm3',
      title: 'Lipicard',
      description: 'Cholestrol',
      alarmTime: TimeOfDay(hour: 8, minute: 30),
      //imageurl:
      //"data:image/jpeg;base64,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",
      imageurl: null,
      quantity: 30,
      /* isMorning: true,
      isAfternoon: false,
      isEvening: false, */
    ), */
  ];

  final String authToken;
  final String userId;
  MedicineList(this.authToken, this.userId, this._items);

  var showMorningOnly = false;
  var showAfternoonOnly = false;
  var showEveningOnly = false;
  //for outputing different grid data
  List<Medicine> get items {
    if (showMorningOnly) {
      return _items.where((meditem) => meditem.isMorning).toList();
    }
    if (showAfternoonOnly) {
      return _items.where((meditem) => meditem.isAfternoon).toList();
    }
    if (showEveningOnly) {
      return _items.where((meditem) => meditem.isEvening).toList();
    }
    return [..._items];
  }

  Medicine findById(String id) {
    return _items.firstWhere((med) => med?.id == id, orElse: () => null);
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm();
    return format.format(dt);
  }

  TimeOfDay stringToTimeOfDay(String tod) {
    final format = DateFormat.jm(); //"6:00 AM"
    return TimeOfDay.fromDateTime(format.parse(tod));
  }

  Future<String> fetchUser() async {
    const url =
        'https://flutter-carewise-default-rtdb.firebaseio.com/users.json';
    try {
      final response = await http.get(url);
      final fetchedData = json.decode(response.body) as Map<String, dynamic>;
      String userid = fetchedData['id'];
      print(userid);
      return userid;
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchAndSetMedicines() async {
    final url =
        'https://flutter-carewise-default-rtdb.firebaseio.com/medicines.json?auth=$authToken&orderBy="userId"&equalTo="$userId"';
    try {
      final response = await http.get(url);
      final List<Medicine> loadedMeds = [];
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      extractedData.forEach((medID, medData) {
        loadedMeds.add(Medicine(
          id: medID,
          title: medData['title'],
          alarmTime: stringToTimeOfDay(medData['alarmTime']),
          imageurl: medData['imageUrl'],
          description: medData['description'],
          quantity: medData['quantity'],
          //userId: medData['userId'],
        ));
      });
      _items = loadedMeds;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addItem(Medicine med) async {
    final url =
        'https://flutter-carewise-default-rtdb.firebaseio.com/medicines.json?auth=$authToken';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': med.title,
          'description': med.description,
          'alarmTime': formatTimeOfDay(med.alarmTime)?.toString(),
          'quantity': med.quantity,
          'imageUrl': med.imageurl,
          'userId': userId,
        }),
      );
      final newMed = Medicine(
        id: json.decode(response.body)['name'],
        title: med.title,
        description: med.description,
        alarmTime: med.alarmTime,
        imageurl: med.imageurl,
        quantity: med.quantity,
      );
      _items.add(newMed);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> deleteItem(String id) async {
    final url =
        'https://flutter-carewise-default-rtdb.firebaseio.com/medicines/$id.json?auth=$authToken';
    final existingMedIndex = _items.indexWhere((med) => med.id == id);
    var existingMed = _items[existingMedIndex];

    _items.removeAt(existingMedIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingMedIndex, existingMed);
      notifyListeners();
      throw CustomExceptions('Something went wrong, Could not delete');
    }
    existingMed = null;
  }

  Future<void> editAndSetMedicines(String id, Medicine editedMed) async {
    final medIndex = _items.indexWhere((med) => med.id == id);
    final url =
        'https://flutter-carewise-default-rtdb.firebaseio.com/medicines/$id.json?auth=$authToken';
    if (medIndex >= 0) {
      try {
        await http.patch(url,
            body: json.encode({
              'title': editedMed.title,
              'quantity': editedMed.quantity,
              'alarmTime': formatTimeOfDay(editedMed.alarmTime),
              'description': editedMed.description,
            }));
        _items[medIndex] = editedMed;
        notifyListeners();
      } catch (error) {
        throw error;
      }
    }
  }
}
