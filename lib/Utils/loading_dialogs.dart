import 'package:autoassit/Screens/Login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:autoassit/Screens/HomePage/home.dart';
import 'dart:async';
import 'package:autoassit/Screens/Login/pincode_verify.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoggingOut extends StatefulWidget {

  LoggingOut(
      {Key key})
      : super(key: key);

  @override
  _LoggingOutState createState() => _LoggingOutState();
}

class _LoggingOutState extends State<LoggingOut> {
  @override
  void initState() {
    super.initState();
    // log(widget.fbName);
    navigate();
  }

  navigate() {
    Future.delayed(
      Duration(seconds: 5),
      () {
        // Navigator.pop(context)
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/macha.gif'),
                      fit: BoxFit.cover)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Container(
                child: Text("Logging You Out..",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 15,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SentScreen extends StatefulWidget {
  final  phone;

  SentScreen(
      {Key key,
      this.phone})
      : super(key: key);

  @override
  _SentScreenState createState() => _SentScreenState();
}

class _SentScreenState extends State<SentScreen> {

  @override
  void initState() {
    super.initState();
    
    Future.delayed(
      Duration(seconds: 4),
      () {
        // Navigator.pop(context);
        final phoneNum = widget.phone;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PincodeVerify(
              phone: phoneNum,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/sent.gif'),
                      fit: BoxFit.cover)),
            ),
            Container(
                child: Text("Otp Sent !",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 15,
                    )))
          ],
        ),
      ),
    );
  }
}

class VerifyingScreen extends StatefulWidget {

  VerifyingScreen(
      {Key key})
      : super(key: key);

  @override
  _VerifyingScreenState createState() => _VerifyingScreenState();
}

class _VerifyingScreenState extends State<VerifyingScreen> {

    SharedPreferences login;

  @override
  void initState() {
    super.initState();
    initializeAuth();
  }

  navigateToHome(){
    Future.delayed(
      Duration(seconds: 6),
      () {
    
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      },
    );
  }

  void initializeAuth() async {
    SharedPreferences login = await SharedPreferences.getInstance();
    final _token = login.getString("gettoken");
    print("token = "+ _token);

    SharedPreferences initializeToken = await SharedPreferences.getInstance();
    initializeToken.setString("authtoken", _token);

    navigateToHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/macha.gif'),
                      fit: BoxFit.cover)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Container(
                child: Text("Verifying Your Account !",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 15,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VerifyPhoneScreen extends StatefulWidget {
  
  VerifyPhoneScreen(
      {Key key})
      : super(key: key);

  @override
  _VerifyPhoneScreenState createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  @override
  void initState() {
    // log(widget.fbName);
    navigate();
    super.initState();
  }

   navigate() {
    Future.delayed(
      Duration(seconds: 5),
      () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SentScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/sending.gif'),
                      fit: BoxFit.cover)),
            ),
            Container(
              child: Text('Verifying Phone Number..!',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 15,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
