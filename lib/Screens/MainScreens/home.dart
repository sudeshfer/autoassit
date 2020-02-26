import 'dart:developer';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:connection_status_bar/connection_status_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: _onBackPressed,
      child: new Scaffold(
        backgroundColor: Color.fromRGBO(143, 148, 251, .8),
        // appBar: new AppBar(
        //   centerTitle: true,
        //   title: new Text("Auto Assist"),
        //   elevation:
        //       defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
        // ),

        drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountEmail: null,
                accountName: new Text("0711231231"),
                currentAccountPicture: new CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  child: new Text("A"),
                ),
              ),
              new Divider(),
              new ListTile(
                title: new Text("Customers"),
                trailing: new Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              new Divider(),
              new ListTile(
                title: new Text("Close"),
                trailing: new Icon(Icons.close),
                onTap: () => Navigator.of(context).pop(),
              ),
              new Divider(),
            ],
          ),
        ),

        body: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 15.0, left: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.menu),
                    color: Colors.white,
                    onPressed: () {},
                  ),
                  Container(
                    width: 125.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.call_missed_outgoing),
                          color: Colors.white,
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.search),
                          color: Colors.white,
                          onPressed: () {},
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 25.0),
            Padding(
              padding: EdgeInsets.only(left: 40.0),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Image.asset(
                      'assets/images/logo.jpg',
                      width: 50,
                      height: 50,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('AutoAssit',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          letterSpacing: 3,
                          color: Colors.white,
                          fontSize: 25.0))
                ],
              ),
            ),
            SizedBox(height: 40.0),
            Container(
              height: MediaQuery.of(context).size.height - 185.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
              ),
              child: ListView(
                primary: false,
                padding: EdgeInsets.only(left: 25.0, right: 20.0),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 45.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height - 300.0,
                      child: ListView(
                        children: [
                          _goToVehicleList('assets/images/car2.png',
                              'Vehicle List', 'view vehicle list'),
                          _goToCustomerList('assets/images/customer2.png',
                              'Customer List', 'view Customer list')
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  //Vehicle list button function
  Widget _goToVehicleList(String imgPath, String btnName, String btnDes) {
    return Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      child: InkWell(
        onTap: () {
          print("vehicle list opened");
          // Navigator.of(context).push(MaterialPageRoute(
          //     builder: (context) => VehicleListPage(
          //         heroTag: imgPath, buttonName: btnName, buttonDes: btnDes)));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
                child: Row(children: [
              Hero(
                  tag: imgPath,
                  child: Image(
                    image: AssetImage(imgPath),
                    fit: BoxFit.cover,
                    height: 60.0,
                    width: 60.0,
                  )),
              SizedBox(width: 10.0),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(btnName,
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(btnDes,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 15.0,
                        color: Colors.grey,
                      )),
                )
              ])
            ])),
            IconButton(
              icon: Icon(Icons.keyboard_arrow_right),
              color: Colors.black,
              onPressed: () {
                print("vehicle list opened");
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) => VehicleListPage(
                //         heroTag: imgPath,
                //         buttonName: btnName,
                //         buttonDes: btnDes)));
              },
            )
          ],
        ),
      ),
    );
  }

  //Customer list button function
  Widget _goToCustomerList(String imgPath, String btnName, String btnDes) {
    return Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 25.0),
      child: InkWell(
        onTap: () {
          print("customer list opened");
          // Navigator.of(context).push(MaterialPageRoute(
          //     builder: (context) => CustomerListPage(
          //         heroTag: imgPath, buttonName: btnName, buttonDes: btnDes)));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
                child: Row(children: [
              Hero(
                  tag: imgPath,
                  child: Image(
                    image: AssetImage(imgPath),
                    fit: BoxFit.cover,
                    height: 60.0,
                    width: 60.0,
                  )),
              SizedBox(width: 10.0),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(btnName,
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(btnDes,
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 15.0,
                          color: Colors.grey)),
                )
              ])
            ])),
            IconButton(
              icon: Icon(Icons.keyboard_arrow_right),
              color: Colors.black,
              onPressed: () {
                print("customer list opened");
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) => CustomerListPage(
                //         heroTag: imgPath,
                //         buttonName: btnName,
                //         buttonDes: btnDes)));
              },
            )
          ],
        ),
      ),
    );
  }
}
