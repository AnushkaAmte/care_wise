import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/medicine_list.dart';
import '../widgets/inventory_item.dart';

class Inventory extends StatelessWidget {
  static const routeName = '/inventory';
  @override
  Widget build(BuildContext context) {
    final medlist = Provider.of<MedicineList>(context);
    final medicines = medlist.items;
    return Scaffold(
      backgroundColor: Colors.green,
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  'Medicine Name',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Quantity',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: medicines.length,
                  itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                        child: InventoryItem(),
                        value: medicines[i],
                      )),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Item',
        onPressed: () {},
        child: Icon(Icons.add),
        elevation: 2.0,
      ),
    );
  }
}
