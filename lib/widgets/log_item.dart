import 'package:flutter/material.dart';

class LogItem extends StatelessWidget {
  final String id;
  final String title;
  final DateTime day;

  const LogItem(this.id, this.title, this.day);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5.0),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListTile(
          title: Text(title),
          //trailing: Text(day.toString(),
        ), //FIX this
      ),
    );
  }
}
