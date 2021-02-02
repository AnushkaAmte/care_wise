import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/medicine_list.dart';

class MedicineDetail extends StatelessWidget {
  static const routeName = '/medicine-detail';
  @override
  Widget build(BuildContext context) {
    final medicineId = ModalRoute.of(context).settings.arguments as String;
    final loadedMedicne =
        Provider.of<MedicineList>(context).findById(medicineId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedMedicne.title),
      ),
    );
  }
}
