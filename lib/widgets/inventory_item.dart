import 'package:carewise/providers/medicine.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InventoryItem extends StatelessWidget {
  /*  final String id;
  final String title;
  final int quantity;

  const InventoryItem(this.id, this.title, this.quantity); */
  @override
  Widget build(BuildContext context) {
    final med = Provider.of<Medicine>(context);
    //final counter = Provider.of<MedicineProvider>(context).count;
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(color: Color(0xf2fff7)),
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                  child: Text(
                med.title,
                style: TextStyle(fontSize: 20.0),
              )),
              Text(
                med.quantity.toString(),
                style: TextStyle(fontSize: 20.0),
                textAlign: TextAlign.end,
              ),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
