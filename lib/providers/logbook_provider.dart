import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class LogbookItem {
  final String id;
  final String title;
  final DateTime day;

  LogbookItem({
    @required this.id,
    @required this.title,
    @required this.day,
  });
}

class LogBookProvider with ChangeNotifier {
  List<LogbookItem> _items = [];
  final String authToken;
  final String userID;
  LogBookProvider(this.authToken, this.userID, this._items);

  List<LogbookItem> get items {
    return [..._items];
  }

  int get medCount {
    return _items.length;
  }

  Future<void> fetchAndSetLogItems() async {
    final url =
        'https://flutter-carewise-default-rtdb.firebaseio.com/logitems/$userID.json?auth=$authToken';
    final response = await http.get(url);
    final List<LogbookItem> _loadedLogItems = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((logID, logData) => {
          _loadedLogItems.add(LogbookItem(
              day: DateTime.parse(logData['dateTime']),
              id: logID,
              title: logData['title']))
        });
    _items = _loadedLogItems.reversed.toList();
  }

  Future<void> addItem(String id, String title) async {
    final date = DateTime.now();
    final url =
        'https://flutter-carewise-default-rtdb.firebaseio.com/logitems/$userID.json?auth=$authToken';
    try {
      final response = await http.post(url,
          body: json.encode({
            'title': title,
            'dateTime':
                DateTime(date.hour, date.minute).toIso8601String(), //FIX this
          }));
      _items.add(LogbookItem(
          id: json.decode(response.body)['name'],
          title: title,
          day: json.decode(response.body)['dateTime']));
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
