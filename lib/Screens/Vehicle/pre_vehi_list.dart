import 'dart:async';

import 'package:autoassit/Controllers/ApiServices/vehicle_services/getVehicles_service.dart';
import 'package:autoassit/Models/vehicleModel.dart';
import 'package:autoassit/Screens/Jobs/create_job.dart';
import 'package:autoassit/Utils/pre_loader.dart';
import 'package:flutter/material.dart';

class PreVehicleList extends StatefulWidget {
  final username;
  PreVehicleList({Key key,this.username}) : super(key: key);

  @override
  _PreVehicleListState createState() => _PreVehicleListState();
}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class _PreVehicleListState extends State<PreVehicleList> {
  final _debouncer = Debouncer(milliseconds: 500);
  List<Vehicle> vehicle = List();
  List<Vehicle> filteredVehicles = List();

  // List _selectedIndexs = [];
  final _search = TextEditingController();
  bool isSearchFocused = false;
  bool isfetched = true;

    @override
  void initState() {
    super.initState();
    GetVehicleService.getVehicles().then((vehiclesFromServer) {
      setState(() {
        vehicle = vehiclesFromServer;
        filteredVehicles = vehicle;
        isfetched = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false, // this avoids the overflow error
        resizeToAvoidBottomInset: true,
        appBar: _buildTopAppbar(context),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: isfetched? PreLoader():_buildBody(context),
        ));
  }

  Widget _buildTopAppbar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(190.0),
      child: Container(
        color: Colors.transparent,
        height: MediaQuery.of(context).size.height / 0.5,
        alignment: Alignment.center,
        child: _buildStack(context),
      ),
    );
  }

  Widget _buildStack(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          child: Container(
            height: MediaQuery.of(context).size.height - 420.0,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color(0xFF8E8CD8),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(75.0),
                  bottomRight: Radius.circular(75.0)),
            ),
          ),
        ),
        Positioned(
            left: 10,
            top: MediaQuery.of(context).size.height / 20.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Center(
                    child: Image.asset(
                  "assets/images/view.png",
                  width: 140,
                  height: 100,
                )),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Center(
                    child: Text(
                      'Select a \nVehicle First',
                      style: TextStyle(
                          textBaseline: TextBaseline.alphabetic,
                          fontFamily: 'Montserrat',
                          fontSize: 25.0,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w900,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            )),
        Positioned(
            left: 20,
            top: MediaQuery.of(context).size.height / 4.8,
            child: Column(children: <Widget>[_buildSearchBar(context)]))
      ],
    );
  }

   Widget _buildSearchBar(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 30.0),
      width: MediaQuery.of(context).size.width / 1.4,
      height: 45,
      // margin: EdgeInsets.only(top: 32),
      padding: EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
      child: TextField(
        keyboardType: TextInputType.text,
        // controller: _search,
        onTap: () {
          setState(() {
            isSearchFocused = true;
          });
        },
        onChanged: (string) {
          _debouncer.run(() {
            setState(() {
              filteredVehicles = vehicle
                  .where((u) =>
                      (u.vNumber.toLowerCase().contains(string.toLowerCase())))
                  .toList();
            });
          });
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey,
            size: 30,
          ),
          hintText: 'search',
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Container(
            child: _getVehiclesList(index,
                                    'assets/images/owned.png',
                                    filteredVehicles[index].make +
                                    " " +
                                    filteredVehicles[index].model,
                                    filteredVehicles[index].vNumber,
                                    filteredVehicles),
          );
        },
        itemCount: filteredVehicles.length,
      ),
    );
  }

    Widget _getVehiclesList(index, String imgPath, vehiName, vNumber, filteredVehicles) {

    return Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      child: GestureDetector(
        onTap: () {
          _navigateToJobScreen(index);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
                child: Row(children: [
              Image.asset(
                imgPath,
                height: 60.0,
                width: 60.0,
              ),
              SizedBox(width: 10.0),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(vehiName,
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(vNumber,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 15.0,
                        color: Colors.grey,
                      )),
                )
              ])
            ])),
            IconButton(
              icon: Icon(Icons.add_circle_outline),
              color: Colors.black,
              onPressed: () {

                _navigateToJobScreen(index);

              },
            )
          ],
        ),
      ),
    );
  }

  _navigateToJobScreen(index) {

    final vnumber = filteredVehicles[index].vNumber;
    final vehicle_name = filteredVehicles[index].make +" "+ filteredVehicles[index].model;
    final customer_name = filteredVehicles[index].cusName;
    final cusId = filteredVehicles[index].cusid;

    print(vehicle_name +"\n"+ vnumber);

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => CreateJob(
                                     username: widget.username,
                                     vnumber: vnumber,
                                     vehicle_name: vehicle_name,
                                     customer_name: customer_name,
                                     cusId: cusId,)));
  }
}