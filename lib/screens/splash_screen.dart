import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green[400],
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                child: Center(
                  child: Text(
                    'CAREWISE',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontStyle: FontStyle.italic),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
