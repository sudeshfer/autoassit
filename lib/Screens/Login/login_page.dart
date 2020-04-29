import 'dart:io';
import 'package:autoassit/Controllers/ApiServices/auth_services/OtpLoginService.dart';
import 'package:autoassit/Screens/Login/pincode_verify.dart';
import 'package:autoassit/Utils/loading_dialogs.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:progress_dialog/progress_dialog.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _phone = TextEditingController();
  String _errorTxt = '';
  ProgressDialog pr;
  SharedPreferences login;

  

  Future<bool> _onBackPressed() {
    return AwesomeDialog(
            context: context,
            dialogType: DialogType.WARNING,
            // customHeader: Image.asset("assets/images/macha.gif"),
            animType: AnimType.TOPSLIDE,
            btnOkText: "yes",
            btnCancelText: "Hell No..",
            tittle: 'Are you sure ?',
            desc: 'Do you want to exit an App',
            btnCancelOnPress: () {},
            btnOkOnPress: () {
              exit(0);
            }).show() ??
        false;
  }

  @override
  void initState() {
    // TODO: implement initState

    // _phone.clear();
  }

  @override
  void dispose() {
    // _phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth  = MediaQuery.of(context).size.width;

    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);

    pr.style(
        message: 'Verifying Phone...',
        borderRadius: 10.0,
        progressWidget: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/loading2.gif'),
                    fit: BoxFit.cover))),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progressTextStyle: TextStyle(fontFamily: 'Montserrat'));

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: new Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: false, // this avoids the overflow error
        resizeToAvoidBottomInset: true,
        body: new GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
            setState(() {
              _errorTxt = "";
            });
          },
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: screenHeight/2,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/background.png'),
                          fit: BoxFit.fill)),
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          // left: 140,
                          margin: EdgeInsets.only(top:50),
                          width:  MediaQuery.of(context).size.width /0.2,
                          height: 400,
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/loginbg.gif'))),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 100),
                        child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:20.0,left:30,right:30),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(143, 148, 251, .2),
                                  blurRadius: 20.0,
                                  offset: Offset(0, 10))
                            ]),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Color(0xFFE0E0E0)))),
                              child: TextField(
                                controller: _phone,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                    icon: Icon(Icons.phone_android),
                                    labelText: 'Phone Number',
                                    errorText: _errorTxt,
                                    errorBorder: _errorTxt.isEmpty
                                        ? OutlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: Color(0xFFFFFF)))
                                        : null,
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFFE0E0E0)))
                                    //hintText: "TYpe Your Phone number",
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () {
                          if (validatePhone()) {
                            initializeLogin();
                          }
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(colors: [
                                Color.fromRGBO(143, 148, 251, 1),
                                Color.fromRGBO(143, 148, 251, .6),
                              ])),
                          child: Center(
                            child: Text(
                              "Next",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed("/forgotpw");
                        },
                        child: Text(
                          "Trouble Loggin in ?",
                          style: TextStyle(
                              color: Color.fromRGBO(143, 148, 251, 1)),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validatePhone() {
    if (_phone.text == '') {
      setState(() {
        _errorTxt = "This Field can't be empty !";
      });
      return false;
    } else if (_phone.text.length >= 9) {
      print("valid 4n number");
      return true;
    } else {
      setState(() {
        _errorTxt = "This should long 10 digits !";
      });
      return false;
    }
  }

  void initializeLogin() {
    pr.show();
    final phonenum = _phone.text;
    print(phonenum);
    final body = {"phone": "$phonenum"};

    LoginwithOtpService.LoginWithOtp(body).then((success) async {
      print(success);
      if (success) {
        SharedPreferences login = await SharedPreferences.getInstance();
        final _token = login.getString("gettoken");
        final _usrename = login.getString("username");
        print(_token);

        SharedPreferences logininit = await SharedPreferences.getInstance();
        logininit.setString("token", _token);
        pr.hide();

        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SentScreen(
                  phone: "+94" + _phone.text,
                  username: _usrename,
                )));
      } else {
        pr.hide();
        print("invalid num");
        setState(() {
          _errorTxt = "This Number doesn't belongs to an account ! ";
        });
      }
    });
  }
}
