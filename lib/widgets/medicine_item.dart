import 'package:carewise/screens/medicine_detail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MedicineItem extends StatelessWidget {
  final String id;
  final String title;
  final imageurl;
  final String description;
  final TimeOfDay alarmtime;

  MedicineItem(
      this.id, this.title, this.imageurl, this.description, this.alarmtime);
  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm();
    return format.format(dt);
  }

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              MedicineDetail.routeName,
              arguments: id,
            );

            //Overlay();
          },
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
                  CircleAvatar(
                    radius: 40.0,
                    backgroundColor: Colors.black,
                    backgroundImage: //imageurl != null
                        //? FileImage(imageurl):
                        NetworkImage(
                            'https://www.practostatic.com/practopedia-v2-images/res-750/aa8a521bcd0f4494ceb54bee5171d1c7c01ee09b1.jpg'),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(description),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Icon(Icons.alarm),
                      Text(formatTimeOfDay(alarmtime)),
                      FlatButton(
                        onPressed: () {},
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
      ),
    );
  }
}
