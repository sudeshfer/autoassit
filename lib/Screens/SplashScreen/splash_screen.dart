import 'dart:developer';

import 'package:autoassit/Screens/HomePage/home.dart';
import 'package:autoassit/Screens/Login/login_page.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SharedPreferences initializeToken;

  @override
  void initState() {
    super.initState();
    
    checkLoginStatus();
  }

  navigateToHome() async {
    SharedPreferences login = await SharedPreferences.getInstance();
    final _usrename = login.getString("username");
    Future.delayed(
      Duration(seconds: 5),
      () {
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(
          username: _usrename,
        ),
        ),
        );
      },
    );
  }

   navigateToLogin(){
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

  checkLoginStatus() async {

    initializeToken = await SharedPreferences.getInstance();
    if (initializeToken.getString("authtoken") == null) {
      navigateToLogin();
    } 
    else 
    {
      initializeToken = await SharedPreferences.getInstance();
      final _token = initializeToken.getString("authtoken");
      print(_token);
      navigateToHome();
    }
  }



  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Center(
        child: Image.asset('assets/images/logo.png',width: 250,height: 250,),
      ),
    );
  }
}
