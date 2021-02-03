import 'package:flutter/cupertino.dart';

//import './medicine_list.dart';

class InventoryItem {
  @required
  final String id;
  @required
  final String title;
  @required
  int quantity;

  InventoryItem(this.id, this.title, this.quantity);
}

class InventoryProvider with ChangeNotifier {
  //List<MedicineList> _inventoryitems = [];
}
