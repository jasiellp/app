import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  SplashScreenstate createState() => new SplashScreenstate();
}

class SplashScreenstate extends State<SplashScreen> {
  Duration five;
  Timer t2;
  String routeName;

  @override
  void initState() {

    super.initState();
    five = const Duration(seconds: 5);
    t2 = new Timer(five, () {

      routeName = "/Home";
      navigate(context, routeName);
    });
  }

  @override
  void dispose() {
    super.dispose();
    t2.cancel();
  }

  void navigate(BuildContext context, String routename) {
    if (routeName != null) {
      Navigator.of(context).pushReplacementNamed(routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return new Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      body: Center(child: Container(
          width: 260.0,
          padding: EdgeInsets.all(100.0),
          decoration: new BoxDecoration(

              image: new DecorationImage(
            image: const ExactAssetImage('assets/logo.jpeg'),
            fit: BoxFit.fitWidth,
          )),
          child: new Container()),
    ));
  }
}
