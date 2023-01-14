import 'package:flutter/material.dart';
import 'package:flash_chat/components/lrbutton.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'Login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _saving = false;
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  late var newuser;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      color: Colors.white,
      inAsyncCall: _saving,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  )),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: textfield_email_inputdecoration_lr),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: textfield_password_inputdecoration_lr),
              SizedBox(
                height: 24.0,
              ),
              lrbutton(login_button_color, (() async {
                setState(() {
                  _saving = true;
                });
                newuser = await _auth.signInWithEmailAndPassword(
                    email: email, password: password);
                if (newuser != null) {
                  setState(() {
                    _saving = false;
                  });

                  Navigator.restorablePushNamed(context, ChatScreen.id);
                } else {
                  Navigator.restorablePushNamed(context, LoginScreen.id);
                }
              }), 'Login'),
            ],
          ),
        ),
      ),
    );
  }
}
