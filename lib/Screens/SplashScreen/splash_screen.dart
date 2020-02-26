import 'package:autoassit/Screens/Login/login_page.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 5),
      () {
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),
        ),
        );
      },
    );

  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Center(
        child: Image.asset('assets/images/logo.jpg',width: 250,height: 250,),
      ),
    );
  }
}
