import 'package:flutter/material.dart';
import 'package:autoassit/Screens/MainScreens/home.dart';
import 'dart:async';
import 'package:autoassit/Screens/Login/pincode_verify.dart';

class SettingUpScreen extends StatefulWidget {

  SettingUpScreen(
      {Key key})
      : super(key: key);

  @override
  _SettingUpScreenState createState() => _SettingUpScreenState();
}

class _SettingUpScreenState extends State<SettingUpScreen> {
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
            builder: (context) => HomePage(
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
                      image: AssetImage('assets/images/sending.gif'),
                      fit: BoxFit.cover)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Container(
                child: Text("Setting up your profile..",
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


  @override
  void initState() {
    super.initState();
    navigate();
  }

  navigate() {
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
