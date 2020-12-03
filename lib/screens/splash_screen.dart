import 'package:flutter/material.dart';
import 'package:gpa_calculator/constant.dart';
import 'package:gpa_calculator/screens/home.dart';
import 'package:splashscreen/splashscreen.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 3,
        navigateAfterSeconds: Home(),
        image: new Image.asset('assets/images/calculator.png'),
        backgroundColor: kMainColor,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        loaderColor: Colors.white);
  }
}
