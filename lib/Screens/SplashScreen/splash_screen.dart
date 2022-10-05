import 'package:autoassit/Controllers/ApiServices/auth_services/OtpLoginService.dart';
import 'package:autoassit/Models/userModel.dart';
import 'package:autoassit/Providers/AuthProvider.dart';
import 'package:autoassit/Screens/HomePage/home.dart';
import 'package:autoassit/Screens/Login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SharedPreferences initializeToken;
   UserModel userModel;

  @override
  void initState() {
    super.initState();
    
    checkLoginStatus();
  }

  navigateToHome() async {
    SharedPreferences login = await SharedPreferences.getInstance();
    final _usrename = login.getString("username");

    startLogin();
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

  startLogin() async {
    SharedPreferences login = await SharedPreferences.getInstance();
    final phonenum = login.getString("phonenum");
    print("got phone num $phonenum");
    final body = {"phone": "$phonenum"};

    LoginwithOtpService.LoginWithOtp(body,context).then((success) async {
      print(success);
      if (success) {
        
        final _token = login.getString("gettoken");
        userModel = Provider.of<AuthProvider>(context, listen: false).userModel;
        print("garage name isssssssssss ${userModel.garageName}");

        initializeToken.setString("authtoken", _token);
       print("login success");
        Future.delayed(
      Duration(seconds: 3),
      () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => HomePage()));
      },
    );

        
      } else {

        print("login failed");
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => LoginPage()));
      }
    });
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
