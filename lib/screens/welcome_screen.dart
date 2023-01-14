import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/components/lrbutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  late Animation animation1;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
      upperBound: 1,
    );
    // curves = CurvedAnimation(parent: controller, curve: Curves.bounceInOut);
    controller.forward();
    animation =
        ColorTween(begin: Colors.black, end: Colors.white).animate(controller);

    // curves.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     controller.reverse();
    //   } else if (status == AnimationStatus.dismissed) {
    //     controller.forward();
    //   }
    // });
    controller.addListener(() {
      setState(() {});
      print(controller.value);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Hero(
                      tag: 'logo',
                      child: Container(
                        height: 60,
                        child: Image.asset('images/logo.png'),
                      )),
                  Expanded(
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'flash chat',
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 45,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            lrbutton(
                login_button_color,
                (() => {Navigator.pushNamed(context, LoginScreen.id)}),
                'Login'),
            lrbutton(
                register_button_color,
                (() => {Navigator.pushNamed(context, RegistrationScreen.id)}),
                'Register'),
          ],
        ),
      ),
    );
  }
}
