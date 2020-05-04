import 'dart:async';
import 'package:autoassit/Screens/Customer/Widgets/edit_csutomer.dart';
import 'package:autoassit/Screens/Customer/owned_vehicles.dart';
import 'package:autoassit/Screens/Vehicle/addVehicle.dart';
import 'package:autoassit/Utils/pre_loader.dart';
import 'package:flutter/material.dart';
import 'package:autoassit/Models/customerModel.dart';
import 'package:autoassit/Controllers/ApiServices/Customer_Services/getCustomers_Service.dart';
import 'package:folding_cell/folding_cell/widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewCustomer extends StatefulWidget {
  ViewCustomer({Key key}) : super(key: key);

  @override
  _ViewCustomerState createState() => _ViewCustomerState();
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

class _ViewCustomerState extends State<ViewCustomer> {
  final _debouncer = Debouncer(milliseconds: 500);
  List<Customer> customer = List();
  List<Customer> filteredCustomers = List();

  // List _selectedIndexs = [];
  final _search = TextEditingController();

  bool isClicked = false;
  bool isSearchFocused = false;
  bool isfetched = true;
  String isExpanded = "";

  @override
  void initState() {
    super.initState();
    GetCustomerService.getCustomers().then((customersFromServer) {
      setState(() {
        customer = customersFromServer;
        filteredCustomers = customer;
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
          child: isfetched? PreLoader() :_buildBody(context),
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
                  "assets/images/personas.png",
                  width: 150,
                  height: 100,
                )),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Center(
                    child: Text(
                      'Customer   \n      List.. ',
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
              filteredCustomers = customer
                  .where((u) =>
                      (u.fName.toLowerCase().contains(string.toLowerCase())))
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
            margin: EdgeInsets.only(left: 8, right: 8, bottom: 20),
            child: SimpleFoldingCell(
                frontWidget: _buildFrontWidget(index),
                innerTopWidget: _buildInnerTopWidget(index),
                innerBottomWidget: _buildInnerBottomWidget(index),
                cellSize: Size(MediaQuery.of(context).size.width / 0.4,
                    MediaQuery.of(context).size.height / 3.8),
                // padding: EdgeInsets.only(left:25,top: 25,right: 25),
                animationDuration: Duration(milliseconds: 300),
                borderRadius: 30,
                onOpen: () => print('$index cell opened'),
                onClose: () => print('$index cell closed')),
          );
        },
        itemCount: filteredCustomers.length,
      ),
    );
  }

  Widget _buildFrontWidget(index) {
    return Builder(
      builder: (BuildContext context) {
        return Container(
            color: Color(0xFFffcd3c),
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/cus_avatar.png'),
                                      fit: BoxFit.cover)),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                    filteredCustomers[index].fName +
                                        " " +
                                        filteredCustomers[index].lName,
                                    // overflow: TextOverflow.clip,
                                    softWrap: true,
                                    style: TextStyle(
                                        color: Color(0xFF2e282a),
                                        fontFamily: 'Montserrat',
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w900)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.phone_iphone,
                                        size: 16, color: Color(0xFFf44336)),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
                                      child: Text(
                                          filteredCustomers[index].mobile,
                                          style: TextStyle(
                                              color: Color(0xFF2e282a),
                                              fontFamily: 'OpenSans',
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w400)),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.email,
                                        size: 16, color: Color(0xFFf44336)),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.4,
                                        child: Text(
                                            filteredCustomers[index].email,
                                            softWrap: true,
                                            style: TextStyle(
                                                color: Color(0xFF2e282a),
                                                fontFamily: 'OpenSans',
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w400)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10, left: 3, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: FlatButton(
                            onPressed: () {
                              print("clicked on attach btn");
                              final cusId = filteredCustomers[index].cusid;
                              final cusName = filteredCustomers[index].fName +
                                  " " +
                                  filteredCustomers[index].lName;

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AddVehicle(
                                        customer_id: cusId,
                                        customer_name: cusName,
                                      )));
                            },
                            child: Text(
                              "Attach Vehicle",
                            ),
                            textColor: Colors.white,
                            color: Colors.indigoAccent,
                            splashColor: Colors.white.withOpacity(0.5),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            SimpleFoldingCellState foldingCellState =
                                context.ancestorStateOfType(
                                    TypeMatcher<SimpleFoldingCellState>());
                            foldingCellState?.toggleFold();
                          },
                          child: Container(
                              height: 40,
                              width: 40,
                              margin: const EdgeInsets.only(top: 5),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/arrowdown.png'),
                                      fit: BoxFit.cover))),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: FlatButton(
                            onPressed: () async {
                              final cusId = filteredCustomers[index].cusid;
                              final cusName = filteredCustomers[index].fName +
                                  " " +
                                  filteredCustomers[index].lName;

                              SharedPreferences ownedVehi =
                                  await SharedPreferences.getInstance();
                              ownedVehi.setString("cusId", cusId);

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => OwnedVehicles(
                                        customer_id: cusId,
                                        customer_name: cusName,
                                      )));
                            },
                            child: Text(
                              "Owned Vehicles",
                            ),
                            textColor: Colors.white,
                            color: Colors.indigoAccent,
                            splashColor: Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }

  Widget _buildInnerTopWidget(index) {
    return Container(
        color: Color(0xFF66BB6A),
        alignment: Alignment.center,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 7.0,right: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  buildInnerFields(index, Icons.phone, "Telephone :",
                      filteredCustomers[index].telephone),
                  buildInnerFields(index, Icons.code, "Adress L1 :",
                      filteredCustomers[index].adL1),
                  buildInnerFields(index, Icons.streetview, "Adress L2 :",
                      filteredCustomers[index].adL2),
                  buildInnerFields(index, Icons.location_city, "Adress L3 :",
                      filteredCustomers[index].adL3),
                  buildInnerFields(index, Icons.supervised_user_circle,
                      "User Role :", filteredCustomers[index].role),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 0.0),
              child: Container(
                margin: EdgeInsets.only(right:5),
                height: MediaQuery.of(context).size.height/6,
                width: MediaQuery.of(context).size.width/5.3,
                decoration: BoxDecoration(
                    color: Color(0xFFffcd3c), shape: BoxShape.circle),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Credit Limit"),
                    Text(filteredCustomers[index].cLimit,
                        style: TextStyle(
                            color: Color(0xFFef5350),
                            fontFamily: 'OpenSans',
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Padding buildInnerFields(index, IconData icon, String title, String data) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(icon, size: 18, color: Color(0xFFFB8C00)),
          Text(
            title,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(data,
                style: TextStyle(
                    color: Color(0xFF2e282a),
                    fontFamily: 'OpenSans',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Widget _buildInnerBottomWidget(index) {
    return Builder(builder: (context) {
      return Container(
        color: Color(0xFFe57373),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              alignment: Alignment.bottomCenter,
              child: FlatButton(
                onPressed: () {
                  print("clicked edit btn");
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return Dialog(
                           child: EditCustomer(fname: filteredCustomers[index].fName,
                                               lname: filteredCustomers[index].lName,
                                               email: filteredCustomers[index].email),
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.all(Radius.circular(12))
                           ),
                        );
                      }
                    );
                },
                child: Text(
                  "Edit Details",
                ),
                textColor: Colors.white,
                color: Colors.indigoAccent,
                splashColor: Colors.white.withOpacity(0.5),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: FlatButton(
                onPressed: () {
                  SimpleFoldingCellState foldingCellState = context
                      .ancestorStateOfType(TypeMatcher<SimpleFoldingCellState>());
                  foldingCellState?.toggleFold();
                },
                child: Text(
                  "Close Card",
                ),
                textColor: Colors.white,
                color: Colors.indigoAccent,
                splashColor: Colors.white.withOpacity(0.5),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: FlatButton(
                onPressed: () {
                  print("clicked delete btn");
                },
                child: Text(
                  "Delete Customer",
                ),
                textColor: Colors.white,
                color: Colors.indigoAccent,
                splashColor: Colors.white.withOpacity(0.5),
              ),
            ),
          ],
        ),
      );
    });
  }
}
