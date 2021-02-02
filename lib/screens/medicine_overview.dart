import 'package:flutter/material.dart';

import '../widgets/medicine_grid.dart';

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
    );
  }
}
