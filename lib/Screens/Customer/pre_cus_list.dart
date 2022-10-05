import 'dart:async';

import 'package:autoassit/Controllers/ApiServices/Customer_Services/getCustomers_Service.dart';
import 'package:autoassit/Models/customerModel.dart';
import 'package:autoassit/Screens/Vehicle/addVehicle.dart';
import 'package:autoassit/Utils/noResponseWidgets/noCustomersMsg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skeleton/flutter_skeleton.dart';

class PreCustomerList extends StatefulWidget {
  PreCustomerList({Key key}) : super(key: key);

  @override
  _PreCustomerListState createState() => _PreCustomerListState();
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

class _PreCustomerListState extends State<PreCustomerList> {
  final _debouncer = Debouncer(milliseconds: 500);
  List<Customer> customer = List();
  List<Customer> filteredCustomers = List();

  // List _selectedIndexs = [];
  final _search = TextEditingController();
  bool isSearchFocused = false;
  bool isfetched = true;
  bool isEmpty = false;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    GetCustomerService.getCustomers().then((customersFromServer) {
      if (customersFromServer.isNotEmpty) {
        setState(() {
          customer = customersFromServer;
          filteredCustomers = customer;
          isfetched = false;
        });
      } else {
        setState(() {
          isEmpty = true;
          isfetched = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // this avoids the overflow error
        resizeToAvoidBottomInset: true,
        appBar: _buildTopAppbar(context),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: isfetched
              ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListSkeleton(
                    style: SkeletonStyle(
                        theme: SkeletonTheme.Light,
                        isShowAvatar: false,
                        isCircleAvatar: false,
                        barCount: 3,
                        // colors: [Color(0xFF8E8CD8), Color(0xFF81C784), Color(0xffFFE082)],
                        isAnimation: true),
                  ),
                )
              : isEmpty
                  ? NoCustomersMsg()
                  : _buildBody(context),
        ));
  }

  Widget _buildTopAppbar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(150.0),
      child: Container(
        color: Colors.transparent,
        // height: MediaQuery.of(context).size.height / 0.5,
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
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(75.0), bottomRight: Radius.circular(75.0)),
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
                  "assets/images/personas.png",
                  // width: 150,
                  height: MediaQuery.of(context).size.height / 8.0,
                )),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Center(
                    child: Text(
                      'Select a \ncustomer 1st',
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
        // Positioned(
        //     left: 20,
        //     top: MediaQuery.of(context).size.height / 4.8,
        //     child: Column(children: <Widget>[_buildSearchBar(context)]))
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      height: MediaQuery.of(context).size.height / 15,
      margin: EdgeInsets.only(top: 15),
      // margin: EdgeInsets.only(top: 32),
      padding: EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)), color: Colors.white, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
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
              filteredCustomers = customer.where((u) => (u.fName.toLowerCase().contains(string.toLowerCase()))).toList();
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
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildSearchBar(context),
          ListView.builder(
            scrollDirection: Axis.vertical,
            controller: _scrollController,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                child: _getCustomerList(index, 'assets/images/cus_avatar.png', filteredCustomers[index].fName + " " + filteredCustomers[index].lName,
                    filteredCustomers[index].cusid, filteredCustomers),
              );
            },
            itemCount: filteredCustomers.length,
          ),
        ],
      ),
    );
  }

  Widget _getCustomerList(index, String imgPath, cusName, phone, filteredCustomers) {
    return Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      child: GestureDetector(
        onTap: () {
          _navigateToVehicleRegistration(index);
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
                  child: Text(cusName, style: TextStyle(fontFamily: 'Montserrat', fontSize: 17.0, fontWeight: FontWeight.bold, letterSpacing: 1)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(phone,
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
                _navigateToVehicleRegistration(index);
              },
            )
          ],
        ),
      ),
    );
  }

  _navigateToVehicleRegistration(index) {
    final customerId = filteredCustomers[index].cusid;
    final customerName = filteredCustomers[index].fName + " " + filteredCustomers[index].lName;

    print(customerId + "\n" + customerName);

    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddVehicle(customer_id: customerId, customer_name: customerName)));
  }
}
