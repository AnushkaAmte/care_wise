import 'package:flutter/cupertino.dart';

import './medicine_list.dart';

class InventoryItem {
  final String id;
  final String title;
  int quantity;
  final List<MedicineList> items;

  InventoryItem(
      {@required this.id,
      @required this.title,
      @required this.quantity,
      @required this.items});
}

class InventoryProvider with ChangeNotifier {
  List<InventoryItem> _invItems = [];

  List<InventoryItem> get invItems {
    return [..._invItems];
  }

  List addItem(List<MedicineList> medItems, int count, String title) {
    invItems.insert(
      0,
      InventoryItem(
          id: DateTime.now().toString(),
          quantity: count,
          title: title,
          items: medItems),
    );
    return invItems;
  }
}

/* void makeList(String itemId){
  inventoryItems.addAll({});
}*/
