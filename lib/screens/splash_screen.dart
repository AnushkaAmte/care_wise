import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(
            width: double.infinity,
            height: 40,
          ),
          Text('Loading.....')
        ],
      ),
    ));
  }
}
