import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './medicine_item.dart';
import '../providers/medicine_list.dart';

class MedicineGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final medicineData = Provider.of<MedicineList>(context);
    final medicines = medicineData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: medicines.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 10.0, mainAxisSpacing: 10.0),
      itemBuilder: (ctx, i) => MedicineItem(
          medicines[i].id,
          medicines[i].title,
          medicines[i].imageurl,
          medicines[i].description,
          medicines[i].alarmTime),
    );
  }
}
