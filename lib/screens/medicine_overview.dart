import 'package:flutter/material.dart';

import '../widgets/medicine_grid.dart';
import '../screens/add_medicine.dart';

class MedicineOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: MedicineGrid(),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Medicine',
        onPressed: () {
          Navigator.of(context).pushNamed(AddMedicine.routeName);
        },
        child: Icon(Icons.add),
        elevation: 2.0,
      ),
    );
  }
}
