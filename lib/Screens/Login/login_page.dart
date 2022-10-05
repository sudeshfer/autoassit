import 'dart:io';

import 'package:autoassit/Controllers/ApiServices/auth_services/OtpLoginService.dart';
import 'package:autoassit/Models/userModel.dart';
import 'package:autoassit/Providers/AuthProvider.dart';
import 'package:autoassit/Screens/Login/Widgets/bezierContainer.dart';
import 'package:autoassit/Utils/loading_dialogs.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  UserModel userModel;

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
    final screenWidth = MediaQuery.of(context).size.width;

    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);

    pr.style(
        message: 'Verifying Phone...',
        borderRadius: 10.0,
        progressWidget: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/loading2.gif'), fit: BoxFit.cover))),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progressTextStyle: TextStyle(fontFamily: 'Montserrat'));

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: new Scaffold(
        backgroundColor: Colors.white,
        // this avoids the overflow error
        resizeToAvoidBottomInset: true,
        body: new GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
            setState(() {
              _errorTxt = "";
            });
          },
          child: SingleChildScrollView(
              child: Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                Positioned(top: -MediaQuery.of(context).size.height * .17, right: -MediaQuery.of(context).size.width * .3, child: BezierContainer()),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: SizedBox(),
                      ),
                      _title(),
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height / 25,
                      // ),
                      _emailPasswordWidget(),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      _submitButton(),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed("/forgotpw");
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.centerRight,
                          child: Text('Forgot Password ?', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                        ),
                      ),
                      _divider(),
                      // _facebookButton(),
                      Expanded(
                        flex: 2,
                        child: SizedBox(),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: _createAccountLabel(),
                ),
                // Positioned(top: 40, left: 0, child: _backButton()),
              ],
            ),
          )),
        ),
      ),
    );
  }

  Widget _backButton() {
    return InkWell(
      onTap: () {
        // Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Image.asset(
          'assets/images/logo.png',
          width: 50,
          height: 50,
        ),
      ),
    );
  }

  Widget _entryField(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: _phone,
              keyboardType: TextInputType.number,
              // obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true,
                  errorText: _errorTxt,
                  errorBorder: _errorTxt.isEmpty ? OutlineInputBorder(borderSide: new BorderSide(color: Color(0xFFFFFF))) : null,
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFE0E0E0)))))
        ],
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () {
        print("clicked");
        print(_phone.text);
        if (validatePhone()) {
          initializeLogin();
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[BoxShadow(color: Colors.grey.shade200, offset: Offset(2, 4), blurRadius: 5, spreadRadius: 2)],
            gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [
              Color.fromRGBO(143, 148, 251, 1),
              Color.fromRGBO(143, 148, 251, .6),
            ])),
        child: Text(
          'Next',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _facebookButton() {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff1959a9),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5), topLeft: Radius.circular(5)),
              ),
              alignment: Alignment.center,
              child: Text('f', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w400)),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff2872ba),
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(5), topRight: Radius.circular(5)),
              ),
              alignment: Alignment.center,
              child: Text('Log in with Facebook', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createAccountLabel() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Trouble Loggin in  ?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed("/forgotpw");
            },
            child: Text(
              'Here',
              style: TextStyle(color: Color(0xffe53935), fontSize: 13, fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }

  Widget _title() {
    return Center(
      child: Image.asset('assets/images/logo.png', width: MediaQuery.of(context).size.width / 2.5, height: MediaQuery.of(context).size.height / 4.5),
    );
    // RichText(
    //   textAlign: TextAlign.center,
    //   text: TextSpan(
    //       text: 'Auto'.toUpperCase(),
    //       style: GoogleFonts.portLligatSans(
    //         textStyle: Theme.of(context).textTheme.display1,
    //         fontSize: 30,
    //         fontWeight: FontWeight.w700,
    //         color: Color(0xffe53935),
    //       ),
    //       children: [
    //         TextSpan(
    //           text: 'Assist'.toUpperCase(),
    //           style: TextStyle(color: Colors.black, fontSize: 30),
    //         ),
    //       ]),
    // );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Phone Number :"),
        // _entryField("Password", isPassword: true),
      ],
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

    LoginwithOtpService.LoginWithOtp(body, context).then((success) async {
      print(success);
      if (success) {
        SharedPreferences login = await SharedPreferences.getInstance();
        login.setString("phonenum", phonenum);
        final _token = login.getString("gettoken");
        final _usrename = login.getString("username");
        userModel = Provider.of<AuthProvider>(context, listen: false).userModel;
        print("garage name isssssssssss ${userModel.garageName}");

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
