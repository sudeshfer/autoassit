import 'package:autoassit/Controllers/ApiServices/Customer_Services/getCustomer_vehicles.dart';
import 'package:autoassit/Models/vehicleModel.dart';
import 'package:autoassit/Utils/pre_loader.dart';
import 'package:flutter/material.dart';
import 'package:folding_cell/folding_cell/widget.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OwnedVehicles extends StatefulWidget {
  final customer_id;
  final customer_name;
  OwnedVehicles({Key key,this.customer_id,this.customer_name}) : super(key: key);

  @override
  _OwnedVehiclesState createState() => _OwnedVehiclesState();
}

class _OwnedVehiclesState extends State<OwnedVehicles> {

  SharedPreferences ownedVehi;
  List<Vehicle> vehicle = List();
  ProgressDialog pr;
  bool isfetched = true;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("customer id = " + widget.customer_id);
    print("customer name = " + widget.customer_name);
    getCusVehicles();
  }

  getCusVehicles() async {
    SharedPreferences ownedVehi = await SharedPreferences.getInstance();
    final body = {"cusID": ownedVehi.getString("cusId")};

    GetCustomerVehicles.getVehicles(body).then((vehiclesfromserver){
         setState(() {
           vehicle = vehiclesfromserver;
           isfetched = false;
         });
         print("vehicles fetched");
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
      ) 
        );
  }

   Widget _buildTopAppbar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(150.0),
      child: Container(
        color: Colors.transparent,
        height: MediaQuery.of(context).size.height / 5.6,
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
            height: MediaQuery.of(context).size.height / 3.8,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color(0xFF81C784),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(75.0),
                  bottomRight: Radius.circular(75.0)),
            ),
          ),
        ),
        Positioned(
            left: 10,
            top: MediaQuery.of(context).size.height / 25.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Center(
                    child: Image.asset(
                  "assets/images/owned.png",
                  width: 150,
                  height: 100,
                )),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0,top: 10),
                  child: Center(
                    child: Text(
                      widget.customer_name +"'s\n    Vehicles List. . . . ",
                      style: TextStyle(
                          textBaseline: TextBaseline.alphabetic,
                          fontFamily: 'Montserrat',
                          fontSize: 18.0,
                          fontWeight: FontWeight.w900,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ))
      ],
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
        itemCount: vehicle.length,
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
                Text(vehicle[index].cusName,
                    style: TextStyle(
                        color: Color(0xFF2e282a),
                        fontFamily: 'OpenSans',
                        fontSize: 15.0,
                        fontWeight: FontWeight.w800)),
                Text(
                    vehicle[index].make +
                        vehicle[index].model,
                    style: TextStyle(
                        color: Color(0xFF2e282a),
                        fontFamily: 'OpenSans',
                        fontSize: 15.0,
                        fontWeight: FontWeight.w800)),
                Text(vehicle[index].odo,
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
        child: Column(
          children: <Widget>[
            Text(vehicle[index].mYear,
                style: TextStyle(
                    color: Color(0xFF2e282a),
                    fontFamily: 'OpenSans',
                    fontSize: 15.0,
                    fontWeight: FontWeight.w800)),
              Text(vehicle[index].eCapacity,
                style: TextStyle(
                    color: Color(0xFF2e282a),
                    fontFamily: 'OpenSans',
                    fontSize: 15.0,
                    fontWeight: FontWeight.w800)),
              Text(vehicle[index].desc,
                style: TextStyle(
                    color: Color(0xFF2e282a),
                    fontFamily: 'OpenSans',
                    fontSize: 15.0,
                    fontWeight: FontWeight.w800)),              
          ],
        ));
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