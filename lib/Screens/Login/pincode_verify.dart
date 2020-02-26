import 'dart:developer';
import 'package:autoassit/Utils/loading_dialogs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:autoassit/Utils/Animations/FadeAnimation.dart';
import 'package:autoassit/Utils/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

String result;
String enteredOtp;

class PincodeVerify extends StatefulWidget {

    final phone;
 
  PincodeVerify({Key key,this.phone}) : super(key: key);
  
  @override
  _PincodeVerifyState createState() => _PincodeVerifyState();
}

class _PincodeVerifyState extends State<PincodeVerify> {
  String smsCode;
  String verificationId;
  SharedPreferences initiateLogin;
  // final phoneNum;


  // bool isLoading = false;

  @override
  void initState() {
    verifyPhone();
    // _setUserData();
    super.initState();
  }

  // _setUserData() async {

  //    initiateLogin = await SharedPreferences.getInstance();    
  //    final phoneNum =  initiateLogin.getString("phoneNumber");
  //    print(phoneNum);

  // }


 
  Future<bool> _onBackPressed() {
    Navigator.of(context).pop();
  }

  Future<void> verifyPhone() async {
    // setState(() {
    //   isLoading = true;
    // });
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verID) {
      this.verificationId = verID;
      // setState(() {
      //   isLoading = false;
      // });
    };
    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      print('sent');

      // setState(() {
      //   isLoading = false;
      // });
    };
    final PhoneVerificationCompleted verifiedSuccess =
        (AuthCredential phoneAuthCredential) {
      navigate();
      print('verified');
      // setState(() {
      //   isLoading = false;
      // });
    };
    final PhoneVerificationFailed verifyFailed = (AuthException exception) {
      print('${exception.message}');
      // setState(() {
      //   isLoading = false;
      // });
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: widget.phone,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verifiedSuccess,
        verificationFailed: verifyFailed,
        codeSent: smsCodeSent,
        codeAutoRetrievalTimeout: autoRetrieve);

    log("OTP sent");
  }

  navigate() async {
      Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VerifyingScreen(),
      ),
    );
    
  }

  signIn() {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: verificationId,
      smsCode: enteredOtp,
    );
    FirebaseAuth.instance.signInWithCredential(credential).then((user) {
      navigate();
    }).catchError((e) {
      showAlert(
        context: context,
        title:"Empty or Invalid OTP",
      );
      log("Invalid OTP");
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: 
               Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    children: <Widget>[
                      SizedBox(height: 30),
                      Container(
                        child: Padding(
                          padding: EdgeInsets.only(left: 14),
                          child: IconButton(
                            icon: Icon(Icons.arrow_back),
                            color: Colors.black,
                            iconSize: 38,
                            onPressed: () {
                              log('Clikced on back btn');
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                      SizedBox(height: 12),
                      FadeAnimation(
                        0.8,
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                           'Enter the code',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                                fontSize: 22),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      FadeAnimation(
                        0.9,
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 8),
                          child: RichText(
                            text: TextSpan(
                                text: "A verification code has been sent to ",
                                children: [
                                  TextSpan(
                                      text: widget.phone,
                                      style: TextStyle(
                                          color: Color(0xFFf45d27),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)),
                                ],
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 18)),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      FadeAnimation(
                        1,
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 7.0, horizontal: 7.0),
                            child: PinCodeTextField(
                              length: 6,
                              obsecureText: false,
                              shape: PinCodeFieldShape.box,
                              fieldHeight: 50,
                              backgroundColor: Colors.white,
                              fieldWidth: 50,
                              onCompleted: (v) {
                                print("Completed");
                              },
                              onChanged: (val) {
                                enteredOtp = val;
                              },
                            )),
                      ),
                      InkWell(
                        onTap: () {
                          signIn();
                        },
                        child: FadeAnimation(
                          1.2,
                          Container(
                            padding: EdgeInsets.only(top: 32),
                            child: Center(
                              child: Container(
                                height: 51,
                                width: MediaQuery.of(context).size.width / 1.12,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color.fromRGBO(143, 148, 251, 1),
                                Color.fromRGBO(143, 148, 251, 1),
                                      ],
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                child: Center(
                                  child: Text(
                                    'Continue'.toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 30),
                      ),
                      FadeAnimation(
                        1.4,
                        InkWell(
                          onTap: () {
                            verifyPhone();
                          },
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                text: "I didn't get a code",
                                style: TextStyle(
                                    color: Color.fromRGBO(143, 148, 251, 1),
                                    fontSize: 17.5,
                                    fontFamily: 'Montserrat'),
                                children: [
                                  TextSpan(
                                      text: " \n Tap Continue to accept Facebook's Terms",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                          fontFamily: 'Montserrat'))
                                ]),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 14,
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  // Future<bool> navigateToHome() {
  //   return showDialog(
  //     builder: (context) => CupertinoAlertDialog(
  //       title: Text(AppLocalizations.of(context).translate('already_have')),
  //       content: Column(
  //         children: <Widget>[
  //           Text(AppLocalizations.of(context).translate('click_ok_to')),
  //         ],
  //       ),
  //       actions: <Widget>[
  //         FlatButton(
  //           color: Colors.orange,
  //           onPressed: () {
  //             navigateToVerifyingScreen();
  //           },
  //           child: Text(
  //             AppLocalizations.of(context).translate('txt_ok'),
  //             style: TextStyle(
  //                 color: Colors.white,
  //                 fontSize: 14,
  //                 fontFamily: 'Montserrat',
  //                 fontWeight: FontWeight.bold),
  //           ),
  //         )
  //       ],
  //     ),
  //     context: context,
  //   );
  // }

}
