import 'package:carewise/models/custom_exceptions.dart';
import 'package:carewise/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
    'userName': '',
  };
  var _isLoading = false;
  void _displayErr(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('An error ocurred'),
              content: Text(message),
              actions: [
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  void _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        await Provider.of<Auth>(context, listen: false)
            .signIn(_authData['email'], _authData['password']);
      } else {
        await Provider.of<Auth>(context, listen: false)
            .signUp(_authData['email'], _authData['password']);
      }
    } on CustomExceptions catch (error) {
      var errMessage = 'Could not authenticate. Please try again!';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errMessage = 'Email already exists';
      } else {
        errMessage = 'Invalid Credentials';
      }
      _displayErr(errMessage);
    } catch (error) {
      const errMessage = 'Authentication failed. Please try again';
      _displayErr(errMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
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
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty || !value.contains("@"))
                          return "Please enter a valid email";
                        else
                          return null;
                      },
                      onSaved: (value) {
                        _authData['email'] = value;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        icon: Icon(Icons.email),
                        hintText: 'Email',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 30.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                      ),
                    ),
                    SizedBox(width: double.infinity, height: 10.0),
                    if (_authMode == AuthMode.Signup)
                      TextFormField(
                          validator: (value) {
                            if (value.isEmpty)
                              return "Please enter a valid usename";
                            else
                              return null;
                          },
                          onSaved: (value) {
                            _authData['username'] = value;
                          },
                          decoration: InputDecoration(
                            icon: Icon(Icons.supervised_user_circle),
                            hintText: 'Username',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 30.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                          )),
                    SizedBox(width: double.infinity, height: 10.0),
                    TextFormField(
                        validator: (value) {
                          if (value.isEmpty)
                            return "Please enter a valid password";
                          else
                            return null;
                        },
                        onSaved: (value) {
                          _authData['password'] = value;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          icon: Icon(Icons.lock),
                          hintText: 'Password',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 30.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                        )),
                    SizedBox(width: double.infinity, height: 20.0),
                    if (_isLoading) CircularProgressIndicator(),
                    if (!_isLoading)
                      FlatButton(
                        onPressed: _submit,
                        /*  Navigator.push(
                context,
                new MaterialPageRoute(builder: (ctxt) => new TabBarScreen()),
              ); */

                        child: Text(_authMode == AuthMode.Login
                            ? 'Login'
                            : 'Create Account'),
                        textColor: Colors.white,
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0)),
                      ),
                    SizedBox(width: double.infinity, height: 20.0),
                    Text(_authMode == AuthMode.Login
                        ? 'Not a User?'
                        : 'Already a User?'),
                    FlatButton(
                      onPressed: _switchAuthMode,
                      child: Text(_authMode == AuthMode.Login
                          ? 'Create New Account'
                          : 'I already have an account'),
                      color: Colors.green,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
