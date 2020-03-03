import 'dart:async';
import 'package:flutter/material.dart';
import 'package:autoassit/Models/customerModel.dart';
import 'package:autoassit/Controllers/ApiServices/Customer_Services/getCustomers_Service.dart';
import 'package:folding_cell/folding_cell/widget.dart';

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
  String isExpanded = "";

  @override
  void initState() {
    super.initState();
    GetCustomerService.getCustomers().then((customersFromServer) {
      setState(() {
        customer = customersFromServer;
        filteredCustomers = customer;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false, // this avoids the overflow error
      resizeToAvoidBottomInset: true,
      appBar: _buildTopAppbar(context),
      body:GestureDetector(
        onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
         child: _buildBody(context),
      ) 
      
      
    );
  }

  Widget _buildTopAppbar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(270.0),
      child: Container(
        color: Colors.transparent,
        height: 270.0,
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
            top: 40,
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
                      'Customer List.. ',
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
            top: 180,
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
            margin: EdgeInsets.only(left:30,right:25,bottom: 20),
            child: SimpleFoldingCell(
              frontWidget: _buildFrontWidget(index),
              innerTopWidget: _buildInnerTopWidget(index),
              innerBottomWidget: _buildInnerBottomWidget(index),
              cellSize: Size(MediaQuery.of(context).size.width-100, 125),
              // padding: EdgeInsets.only(left:25,top: 25,right: 25),
              animationDuration: Duration(milliseconds: 300),
                                borderRadius: 30,
                                onOpen: () => print('$index cell opened'),
                                onClose: () => print('$index cell closed')
            ),
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
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(filteredCustomers[index].fName,
                    style: TextStyle(
                        color: Color(0xFF2e282a),
                        fontFamily: 'OpenSans',
                        fontSize: 15.0,
                        fontWeight: FontWeight.w800)),
                Text(
                    filteredCustomers[index].telephone +
                        filteredCustomers[index].mobile,
                    style: TextStyle(
                        color: Color(0xFF2e282a),
                        fontFamily: 'OpenSans',
                        fontSize: 15.0,
                        fontWeight: FontWeight.w800)),
                Text(filteredCustomers[index].role,
                    style: TextStyle(
                        color: Color(0xFF2e282a),
                        fontFamily: 'OpenSans',
                        fontSize: 15.0,
                        fontWeight: FontWeight.w800)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      child: FlatButton(
                        onPressed: () {
                          SimpleFoldingCellState foldingCellState =
                              context.ancestorStateOfType(
                                  TypeMatcher<SimpleFoldingCellState>());
                          foldingCellState?.toggleFold();
                        },
                        child: Text(
                          "View More",
                        ),
                        textColor: Colors.white,
                        color: Colors.indigoAccent,
                        splashColor: Colors.white.withOpacity(0.5),
                      ),
                    ),
                    Container(
                      child: FlatButton(
                        onPressed: () {
                          print("clicked on history btn");
                        },
                        child: Text(
                          "See History",
                        ),
                        textColor: Colors.white,
                        color: Colors.indigoAccent,
                        splashColor: Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ],
            ));
      },
    );
  }

  Widget _buildInnerTopWidget(index) {
    return Container(
        color: Color(0xFFff9234),
        alignment: Alignment.center,
        child: Text(filteredCustomers[index].email,
            style: TextStyle(
                color: Color(0xFF2e282a),
                fontFamily: 'OpenSans',
                fontSize: 15.0,
                fontWeight: FontWeight.w800)));
  }

  Widget _buildInnerBottomWidget(index) {
    return Builder(builder: (context) {
      return Padding(
        padding: const EdgeInsets.only(bottom:8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: FlatButton(
                  onPressed: () {
                    print("clicked edit btn");
                  },
                  child: Text(
                    "Edit",
                  ),
                  textColor: Colors.white,
                  color: Colors.indigoAccent,
                  splashColor: Colors.white.withOpacity(0.5),
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: FlatButton(
                  onPressed: () {
                    SimpleFoldingCellState foldingCellState =
                        context.ancestorStateOfType(
                            TypeMatcher<SimpleFoldingCellState>());
                    foldingCellState?.toggleFold();
                  },
                  child: Text(
                    "Close",
                  ),
                  textColor: Colors.white,
                  color: Colors.indigoAccent,
                  splashColor: Colors.white.withOpacity(0.5),
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: FlatButton(
                  onPressed: () {
                    print("clicked delete btn");
                  },
                  child: Text(
                    "Delete",
                  ),
                  textColor: Colors.white,
                  color: Colors.indigoAccent,
                  splashColor: Colors.white.withOpacity(0.5),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}