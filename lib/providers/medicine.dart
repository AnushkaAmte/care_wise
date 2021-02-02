import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Medicine {
  String id;
  String title;
  String description;
  TimeOfDay alarmTime;
  var imageurl;
  int quantity;
  bool isTaken;

  Medicine({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.alarmTime,
    @required this.imageurl,
    @required this.quantity,
    this.isTaken,
  });
}
