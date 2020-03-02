import 'dart:developer';
import 'dart:io';
import 'package:autoassit/Screens/HomePage/homeWidgets/service_cards.dart';
import 'package:autoassit/Screens/HomePage/homeWidgets/vehicle_cards.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:connection_status_bar/connection_status_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:autoassit/Screens/HomePage/homeWidgets/customer_cards.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:autoassit/Screens/HomePage/homeWidgets/utils.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  String welcome_msg;

  @override
  void initState() {
    // TODO: implement initState
    tabController = TabController(vsync: this, length: 4);
    welcome_msg = Utils.getWelcomeMessage();

    super.initState();
  }

  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: _onBackPressed,
      child: new Scaffold(
          body: ListView(
        children: <Widget>[
          SizedBox(height: 15.0),
          Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(right: 10.0),
              child: _buildHeader(context)),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 60,
                    height: 60,
                  ),
                ),
                Text(
                  'AutoAssit',
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 40.0,
                      fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: _buildTabBar(context),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Container(
              height: MediaQuery.of(context).size.height - 435.0,
              child: _buildTabView(context)
            ),
          ),
          _buildExpansionTile(context)
        ],
      )),
    );
  }

  Widget _buildTabBar(BuildContext context){
    return TabBar(
              controller: tabController,
              indicatorColor: Colors.amber,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey.withOpacity(0.5),
              isScrollable: true,
              tabs: <Widget>[
                Tab(
                  child: Row(
                    children: <Widget>[
                      FaIcon(
                        FontAwesomeIcons.user,
                        size: 14.5,
                      ),
                      Text(
                        'Customers',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    children: <Widget>[
                      // Image.asset('assets/images/vehicles.png',width: 20,height: 20,),
                      FaIcon(
                        FontAwesomeIcons.car,
                        size: 18,
                      ),
                      Text(
                        'Vehicles',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 3.0),
                        child: FaIcon(
                          FontAwesomeIcons.tags,
                          size: 15,
                        ),
                      ),
                      Text(
                        'Services',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    children: <Widget>[
                      FaIcon(
                        FontAwesomeIcons.history,
                        size: 15,
                      ),
                      Text(
                        'Sales History',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              ],
            );
  }

  Widget _buildTabView(BuildContext context){
    return TabBarView(
                controller: tabController,
                children: <Widget>[
                  CustomerList(),
                  VehicleCards(),
                  ServicesList(),
                  CustomerList(),
                ],
              );
  }

  Widget _buildExpansionTile(BuildContext context) {
    return ExpansionTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 8.0),
            child: Text("On-going jobs",
                style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w900)),
          )
        ],
      ),
    );
  }

  Widget _buildWelcomeMsg(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: const EdgeInsets.only(left: 20.0),
      padding: const EdgeInsets.all(5.0),
      child: Text(
        welcome_msg,
        style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 15.0,
            fontWeight: FontWeight.w900),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _buildWelcomeMsg(context),
        FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.grey.withOpacity(0.3),
            mini: true,
            elevation: 0.0,
            child: Image.asset(
              'assets/images/logout.png',
              fit: BoxFit.contain,
            )),
      ],
    );
  }
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
}
