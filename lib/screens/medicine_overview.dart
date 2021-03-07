import 'package:carewise/providers/medicine_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/medicine_grid.dart';
import '../screens/add_medicine.dart';

class MedicineOverview extends StatefulWidget {
  @override
  _MedicineOverviewState createState() => _MedicineOverviewState();
}

class _MedicineOverviewState extends State<MedicineOverview> {
  var _isLoading = false;
  @override
  void initState() {
    // Provider.of<MedicineList>(context).fetchAndSetMedicines();
    setState(() {
      _isLoading = true;
    });
    Future.delayed(Duration.zero).then((_) {
      Provider.of<MedicineList>(context, listen: false)
          .fetchAndSetMedicines()
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
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
