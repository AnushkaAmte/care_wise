/* import 'dart:convert';

//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
/* import './create_account.dart';
import '../widgets/tabbar_screen.dart'; */
import '../widgets/auth_form.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  bool valueCheck = false;
  var _isLoading = false;
  void _submitAuthForm(String email, String username, String password,
      bool isLogin, BuildContext ctx) async {
    const url =
        'https://flutter-carewise-default-rtdb.firebaseio.com/users.json';
    AuthResult authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        /*      await Firestore.instance
            .collection('users')
            .document(authResult.user.uid)
            .setData({'username': username, 'email': email}); */
        http.post(url,
            body: json.encode({
              'id': authResult.user.uid,
              'email': email,
              'password': password,
            }));
      }
    } on PlatformException catch (err) {
      var message = 'An error occured.Please check your credentials';
      if (err.message != null) message = err.message;
      Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
      ));
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SingleChildScrollView(
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
              AuthForm(_submitAuthForm, _isLoading),
            ],
          ),
        ),
      ),
    );
  }
}
 */
