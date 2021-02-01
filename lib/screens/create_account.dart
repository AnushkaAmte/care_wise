import '../main.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            Container(
              height: 50.0,
              child: DrawerHeader(
                child: Text('Need Help?'),
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                ),
              ),
            ),
            Text('Add info about how to create an accout'),
            ListTile(
                title: Text('Got It!'),
                tileColor: Colors.green,
                onTap: () {
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Create New Account'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
            SizedBox(width: double.infinity, height: 10.0),
            TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  icon: Icon(Icons.lock),
                  hintText: 'Confirm Password',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                )),
            FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(builder: (ctxt) => new MyApp()),
                );
              },
              child: Text('Create Account'),
              textColor: Colors.white,
              color: Colors.green,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0)),
            ),
          ],
        ),
      ),
    );
  }
}
