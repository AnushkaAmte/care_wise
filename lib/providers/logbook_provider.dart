import 'package:flutter/foundation.dart';

class LogbookItem {
  final String id;
  final String title;

  LogbookItem({
    @required this.id,
    @required this.title,
  });
}

class LogBookProvider with ChangeNotifier {
  Map<String, LogbookItem> _items = {};

  Map<String, LogbookItem> get items {
    return {..._items};
  }

  int get medCount {
    return _items.length;
  }

  void addItem(String id, String title) {
    _items.putIfAbsent(
        id, () => LogbookItem(id: DateTime.now().toString(), title: title));
    notifyListeners();
  }
}
