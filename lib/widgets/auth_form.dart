import 'package:flutter/material.dart';

//import '../widgets/tabbar_screen.dart';

class AuthForm extends StatefulWidget {
  final void Function(String email, String username, String password,
      bool isLogin, BuildContext ctx) submitFn;
  final bool isLoading;
  AuthForm(this.submitFn, this.isLoading);
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formkey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';

  void _trySubmit() {
    final isValid = _formkey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formkey.currentState.save();
      widget.submitFn(
        _userEmail.trim(),
        _userName.trim(),
        _userPassword.trim(),
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
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
              _userEmail = value;
            },
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.email),
              hintText: 'Email',
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
            ),
          ),
          SizedBox(width: double.infinity, height: 10.0),
          if (!_isLogin)
            TextFormField(
                validator: (value) {
                  if (value.isEmpty)
                    return "Please enter a valid usename";
                  else
                    return null;
                },
                onSaved: (value) {
                  _userName = value;
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.supervised_user_circle),
                  hintText: 'Username',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
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
                _userPassword = value;
              },
              obscureText: true,
              decoration: InputDecoration(
                icon: Icon(Icons.lock),
                hintText: 'Password',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0)),
              )),
          SizedBox(width: double.infinity, height: 20.0),
          if (widget.isLoading) CircularProgressIndicator(),
          if (!widget.isLoading)
            FlatButton(
              onPressed: _trySubmit,
              /*  Navigator.push(
                context,
                new MaterialPageRoute(builder: (ctxt) => new TabBarScreen()),
              ); */

              child: Text(_isLogin ? 'Login' : 'Create Account'),
              textColor: Colors.white,
              color: Colors.green,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0)),
            ),
          SizedBox(width: double.infinity, height: 20.0),
          Text(_isLogin ? 'Not a User?' : 'Already a User?'),
          FlatButton(
            onPressed: () {
              /* Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (ctxt) => new CreateAccount()),
                  ); */
              setState(() {
                _isLogin = !_isLogin;
              });
            },
            child: Text(
                _isLogin ? 'Create New Account' : 'I already have an account'),
            color: Colors.green,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0)),
          ),
        ],
      ),
    );
  }
}
