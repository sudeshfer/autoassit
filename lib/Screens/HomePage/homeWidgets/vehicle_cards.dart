import 'package:flutter/material.dart';

class VehicleCards extends StatefulWidget {
  VehicleCards({Key key}) : super(key: key);

  @override
  _VehicleCardsState createState() => _VehicleCardsState();
}

class _VehicleCardsState extends State<VehicleCards> {

  ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
   
  }

  @override
  Widget build(BuildContext context) {
        return ListView(
      children: <Widget>[
        Container(
          height: 350.0,
          child: ListView(
            padding: EdgeInsets.only(left: 25.0),
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              getVehicleCard('assets/images/add_vehi.png','   Add\nVehicle', onTap: (){print("Go to add vehicle screen !");} ),
              SizedBox(width: 15.0),
              getVehicleCard('assets/images/view.png', '   View\nVehicles', onTap: (){print("Go to view vehicles screen !");}),
              SizedBox(width: 15.0),
              getVehicleCard('assets/images/vehi_history.png', 'Vehicles\nHistory', onTap: (){print("Go to vehicles history screen !");}),
              SizedBox(width: 15.0),
            ],
          ),
        ),
      ],
    );
  }

   getVehicleCard(String imgPath, String cardTitle, {Function() onTap}) {
    return Stack(
      children: <Widget>[
        Container(
          height: 200.0,
          width: 140.0,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: Color(0xFF81C784)),
            height: 225.0,
            width: 200.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(
                  image: AssetImage(imgPath),
                  height: 100.0,
                  width: 120.0,
                ),
                
                    Column(
                      children: <Widget>[
                        Text(
                          cardTitle,
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ],
                    ),
                 
                SizedBox(height: 10.0),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 45.0, top: 175.0),
          child: GestureDetector(
                 onTap: onTap,
                  child: Container(
              height: 50.0,
              width: 50.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0), color: Color(0xFFef9a9a)),
              child:
                  Center(child: Icon(Icons.add_circle, color: Colors.white,size: 30,)),
            ),
          ),
        )
      ],
    );
  }
}