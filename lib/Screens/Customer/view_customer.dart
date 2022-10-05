import 'dart:async';

import 'package:autoassit/Controllers/ApiServices/Customer_Services/getCustomers_Service.dart';
import 'package:autoassit/Models/customerModel.dart';
import 'package:autoassit/Providers/CustomerProvider.dart';
import 'package:autoassit/Screens/Customer/Widgets/delete_customer.dart';
import 'package:autoassit/Screens/Customer/Widgets/edit_csutomer.dart';
import 'package:autoassit/Screens/Customer/owned_vehicles.dart';
import 'package:autoassit/Screens/Vehicle/addVehicle.dart';
import 'package:autoassit/Utils/noResponseWidgets/noCustomersMsg.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skeleton/flutter_skeleton.dart';
import 'package:folding_cell/folding_cell/widget.dart';
import 'package:provider/provider.dart';
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
  bool isEmpty = false;
  String isExpanded = "";
  Customer customerModel;
  int total = 0;
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
          total = filteredCustomers.length;
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

  void removeCustomer(bool isRemove, int index) {
    if (isRemove) {
      print("isremove is $isRemove");
      setState(() {
        filteredCustomers.removeAt(index);
      });
    } else {
      print("doesnt hve to update");
    }
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
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Customer List.. ',
                          style: TextStyle(
                              textBaseline: TextBaseline.alphabetic,
                              fontFamily: 'Montserrat',
                              fontSize: 25.0,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w900,
                              color: Colors.white),
                        ),
                        Container(
                          //  margin: EdgeInsets.only(right: 20),
                          child: Text(
                            "Total Customers - $total",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                        ),
                      ],
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
              filteredCustomers = customer
                  .where((u) => (u.fName.toLowerCase().contains(string.toLowerCase())) || (u.mobile.toLowerCase().contains(string.toLowerCase())))
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
                margin: EdgeInsets.only(left: 8, right: 8, bottom: 20),
                child: SimpleFoldingCell(
                    frontWidget: _buildFrontWidget(index),
                    innerTopWidget: _buildInnerTopWidget(index),
                    innerBottomWidget: _buildInnerBottomWidget(index),
                    cellSize: Size(MediaQuery.of(context).size.width / 0.4, MediaQuery.of(context).size.height / 3.8),
                    // padding: EdgeInsets.only(left:25,top: 25,right: 25),
                    animationDuration: Duration(milliseconds: 300),
                    borderRadius: 30,
                    onOpen: () => print('$index cell opened'),
                    onClose: () => print('$index cell closed')),
              );
            },
            itemCount: filteredCustomers.length,
          ),
        ],
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
                              decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/cus_avatar.png'), fit: BoxFit.cover)),
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
                                child: Text("${filteredCustomers[index].fName}" + " " + "${filteredCustomers[index].lName}",
                                    // overflow: TextOverflow.clip,
                                    softWrap: true,
                                    style:
                                        TextStyle(color: Color(0xFF2e282a), fontFamily: 'Montserrat', fontSize: 20.0, fontWeight: FontWeight.w900)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.phone_iphone, size: 16, color: Color(0xFFf44336)),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
                                      child: Text("${filteredCustomers[index].mobile}",
                                          style: TextStyle(
                                              color: Color(0xFF2e282a), fontFamily: 'OpenSans', fontSize: 15.0, fontWeight: FontWeight.w400)),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.email, size: 16, color: Color(0xFFf44336)),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width / 2.4,
                                        child: Text("${filteredCustomers[index].email}",
                                            softWrap: true,
                                            style: TextStyle(
                                                color: Color(0xFF2e282a), fontFamily: 'OpenSans', fontSize: 15.0, fontWeight: FontWeight.w400)),
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
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10, left: 3, right: 10),
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
                              final cusName = filteredCustomers[index].fName + " " + filteredCustomers[index].lName;

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
                            SimpleFoldingCellState foldingCellState = context.findAncestorStateOfType<SimpleFoldingCellState>();
                            foldingCellState?.toggleFold();
                          },
                          child: Container(
                              height: 40,
                              width: 40,
                              margin: const EdgeInsets.only(top: 5),
                              decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/arrowdown.png'), fit: BoxFit.cover))),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: FlatButton(
                            onPressed: () async {
                              final cusId = filteredCustomers[index].cusid;
                              final cusName = filteredCustomers[index].fName + " " + filteredCustomers[index].lName;

                              SharedPreferences ownedVehi = await SharedPreferences.getInstance();
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
        color: Color(0xFFffcd3c),
        alignment: Alignment.center,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 7.0, right: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  buildInnerFields(index, Icons.phone, "Telephone :", filteredCustomers[index].telephone),
                  buildInnerFields(index, Icons.code, "Adress L1 :", filteredCustomers[index].adL1),
                  buildInnerFields(index, Icons.streetview, "Adress L2 :", filteredCustomers[index].adL2),
                  buildInnerFields(index, Icons.location_city, "Adress L3 :", filteredCustomers[index].adL3),
                  buildInnerFields(index, Icons.supervised_user_circle, "User Role :", filteredCustomers[index].role),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 0.0),
              child: Container(
                margin: EdgeInsets.only(right: 5),
                height: MediaQuery.of(context).size.height / 6,
                width: MediaQuery.of(context).size.width / 5.3,
                decoration: BoxDecoration(color: Color(0xFF81C784), shape: BoxShape.circle),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Credit Limit",
                      textAlign: TextAlign.center,
                    ),
                    Text(filteredCustomers[index].cLimit,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Color(0xFFef5350), fontFamily: 'OpenSans', fontSize: 18.0, fontWeight: FontWeight.w700)),
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
          Icon(icon, size: 18, color: Color(0xFFf44336)),
          Text(
            title,
            style: TextStyle(
                // color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(data, style: TextStyle(color: Color(0xFF2e282a), fontFamily: 'OpenSans', fontSize: 16.0, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Widget _buildInnerBottomWidget(index) {
    return Builder(builder: (context) {
      return Container(
        margin: EdgeInsets.only(bottom: 20),
        color: Color(0xFFe57373),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              alignment: Alignment.bottomCenter,
              child: FlatButton(
                onPressed: () {
                  goToEditDetails(index, context);
                },
                child: Text(
                  "Update Details",
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
                  SimpleFoldingCellState foldingCellState = context.findAncestorStateOfType<SimpleFoldingCellState>();
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
                  goToDelCustomer(index, context);
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

  void goToEditDetails(index, BuildContext context) {
    print("clicked edit btn");
    customerModel = filteredCustomers[index];
    Provider.of<CustomerProvider>(context, listen: false).customerModel = customerModel;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            child: EditCustomer(),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
          );
        });
  }

  Future<void> goToDelCustomer(index, BuildContext context) async {
    print("clicked edit btn");
    customerModel = filteredCustomers[index];
    Provider.of<CustomerProvider>(context, listen: false).customerModel = customerModel;
    bool remove = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            child: DeleteCustomer(),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
          );
        });
    print("issssssssssss $remove");
    removeCustomer(remove, index);
  }

  Future<dynamic> successDialog(String title, String dec) {
    return AwesomeDialog(
        context: context,
        dialogType: DialogType.SUCCES,
        animType: AnimType.TOPSLIDE,
        tittle: title,
        desc: dec,
        // btnCancelOnPress: () {},
        btnOkOnPress: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewCustomer()));
        }).show();
  }
}
