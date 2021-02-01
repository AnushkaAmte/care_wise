//import 'package:CareWise/widgets/tabbar_screen.dart';
import 'package:flutter/material.dart';
import './create_account.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool valueCheck = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'CareWise',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50.0,
              ),
            ),
            SizedBox(width: double.infinity, height: 60.0),
            TextFormField(
                decoration: InputDecoration(
              icon: Icon(Icons.supervised_user_circle),
              hintText: 'Username',
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
            )),
            SizedBox(width: double.infinity, height: 10.0),
            TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  icon: Icon(Icons.lock),
                  hintText: 'Password',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                )),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              Checkbox(
                  value: this.valueCheck,
                  checkColor: Colors.green,
                  onChanged: (bool value) {
                    setState(() {
                      this.valueCheck = value;
                    });
                  }),
              Text('Remember Me'),
            ]),
            SizedBox(width: double.infinity, height: 20.0),
            FlatButton(
              onPressed: () {
                /* Navigator.push(
                  context,
                  new MaterialPageRoute(builder: (ctxt) => new TabBarScreen()),
                ); */
              },
              child: Text('Login'),
              textColor: Colors.white,
              color: Colors.green,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0)),
            ),
            SizedBox(width: double.infinity, height: 20.0),
            Text('Not a User?'),
            FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(builder: (ctxt) => new CreateAccount()),
                );
              },
              child: Text('Create New Account'),
              color: Colors.green,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0)),
            ),
          ],
        ),
      ),
    );
  }
}
