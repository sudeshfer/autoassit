import 'package:autoassit/Screens/Customer/add_customer.dart';
import 'package:autoassit/Screens/Login/login_page.dart';
import 'package:autoassit/Screens/Login/pincode_verify.dart';
import 'package:autoassit/Screens/HomePage/home.dart';
import 'package:autoassit/Screens/SplashScreen/splash_screen.dart';
import 'package:autoassit/Screens/Troublelogin/forgotPassword.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(primarySwatch: Colors.deepPurple),
      home: new SplashScreen(),
      routes: <String, WidgetBuilder>{
        "/login": (BuildContext context) => new LoginPage(),
        "/pincode": (BuildContext context) => new PincodeVerify(),
        "/home": (BuildContext context) => new HomePage(),
        "/forgotpw": (BuildContext context) => new ForgotPassword(),
        "/addCustomer": (BuildContext context) => new AddCustomer(),

       
      },
    );
  }
}