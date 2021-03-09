import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/medicine.dart';
import '../providers/logbook_provider.dart';
import '../screens/medicine_detail.dart';

/* final String id;
  final String title;
  final imageurl;
  final String description;
  final TimeOfDay alarmtime;

  MedicineItem(
      this.id, this.title, this.imageurl, this.description, this.alarmtime); */

class MedicineItem extends StatelessWidget {
  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm();
    return format.format(dt);
  }

  @override
  Widget build(BuildContext context) {
    final med = Provider.of<Medicine>(context);
    final log = Provider.of<LogBookProvider>(context, listen: false);

    return GridTile(
      child: Center(
        child: Card(
          elevation: 10.0,
          child: Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width / 2,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(30.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(MedicineDetail.routeName, arguments: med.id);
                  },
                  child: CircleAvatar(
                    radius: 40.0,
                    backgroundColor: Colors.black,
                    backgroundImage: med.imageurl != null
                        ? NetworkImage(med.imageurl)
                        : NetworkImage(
                            'https://www.practostatic.com/practopedia-v2-images/res-750/aa8a521bcd0f4494ceb54bee5171d1c7c01ee09b1.jpg'),
                  ),
                ),
                Text(
                  med.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(med.description),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Icon(Icons.alarm),
                    Text(formatTimeOfDay(med.alarmTime)),
                    FlatButton(
                      onPressed: () {
                        log.addItem(med.id, med.title);
                        //ERROR: Items out of the screen are not getting added to the logbook
                        //TODO: Resolve this error
                        //TODO: Check the logbook provider & changenotifier.value
                        med.updateCount(med.id);
                        //This function works correctly
                        print(med.quantity);
                      },
                      child: Text("Check"),
                      color: Colors.green,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
