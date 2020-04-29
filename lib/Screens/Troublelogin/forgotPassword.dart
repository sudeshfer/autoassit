import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:autoassit/Screens/Troublelogin/resetPassword.dart';
import 'package:autoassit/Animations/FadeAnimation.dart';
import 'package:autoassit/Controllers/ApiServices/trouble_login/SendResetMailService.dart';
import 'package:progress_dialog/progress_dialog.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _email = TextEditingController();
  String _errorTxt = '';
  bool isLoaidng = false;
  ProgressDialog pr;

  @override
  void initState() {
    setState(() {
      _errorTxt = "";
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);

    pr.style(
        message: 'Sending Email...',
        borderRadius: 10.0,
        progressWidget: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/emailSend.gif'),
                    fit: BoxFit.cover))),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progressTextStyle: TextStyle(fontFamily: 'Montserrat'));

    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          setState(() {
            _errorTxt = "";
          });
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              // SizedBox(height: 40),
              Padding(
                padding: EdgeInsets.only(top: 50.0, left: 14),
                child: Container(
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    color: Colors.black,
                    iconSize: 38,
                    onPressed: () {
                      log('Clikced on back btn');
                      Navigator.of(context).pop();
                    },
                  ),
                  alignment: Alignment.centerLeft,
                ),
              ),

              SizedBox(height: 12),
              FadeAnimation(
                0.8,
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                  child: Text(
                    'Trouble Login in?',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(64, 75, 105, 1),
                        fontFamily: 'Montserrat',
                        fontSize: 22),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              FadeAnimation(
                0.9,
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                  child: RichText(
                    text: TextSpan(
                        text:
                            "Pleace enter your email below to receive your \nAccount reset instructions.",
                        style: TextStyle(
                            color: Color.fromRGBO(64, 75, 105, 1),
                            fontSize: 16)),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              FadeAnimation(
                0.1,
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 7.0, horizontal: 25),
                  child: TextField(
                    controller: _email,
                    decoration: InputDecoration(
                        border: new OutlineInputBorder(
                            borderSide:
                                new BorderSide(color: Color(0xFFE0E0E0))),
                        labelText: 'Email',
                        errorText: _errorTxt,
                        errorBorder: _errorTxt.isEmpty
                            ? OutlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Color(0xFFE0E0E0)))
                            : null,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFE0E0E0)))),
                  ),
                ),
              ),

              FadeAnimation(
                1.2,
                Container(
                  padding: EdgeInsets.only(top: 32),
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        if (checkNull()) {
                          setState(() {
                            _errorTxt = "";
                            isLoaidng = true;
                          });

                          if(validateEmail()){
                           pr.show();

                          final body = {"email": _email.text};

                          SendResetMailService.SendResetEmail(body)
                              .then((success) {
                            if (success) {
                              log('email sent successfully');
                              pr.hide();

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ResetPassword(
                                        resetEmail: _email.text,
                                      )));
                              
                            }
                            else
                            {
                              pr.hide();
                               _errorTxt = "This Email doesnt blongs to an account !";
                            }
                          });

                          // Navigator.of(context).push(MaterialPageRoute(
                          //         builder: (context) => ResetPassword(
                          //               resetEmail: _email.text,
                          //             )));
                         }

                        } else {
                          pr.hide();
                          setState(() {
                            _errorTxt = "You should fill out this field !";
                          });
                        }
                      },
                      child: Container(
                        height: 51,
                        width: MediaQuery.of(context).size.width / 1.12,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color.fromRGBO(143, 148, 251, 1),
                                Color.fromRGBO(143, 148, 251, .6),],
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Center(
                          child: Text(
                            'Send An Email'.toUpperCase(),
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
                height: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool checkNull() {
    if (_email.text == '') {
      return false;
    } else {
      return true;
    }
  }

 ///function tht validate the email
   bool validateEmail(){
    String email= _email.text;
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
    if(emailValid){

      print("Valid email !");
      log("Valid email !");
      return true;
    }
    else{
        setState(() {
          _errorTxt= "This is not a valid email !";
        });
       return false; 
    }
  }

}