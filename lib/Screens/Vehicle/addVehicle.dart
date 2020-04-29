import 'dart:io';
import 'package:autoassit/Controllers/ApiServices/Vehicle_Services/addVehicle_Service.dart';
import 'package:autoassit/Screens/Vehicle/view_vehicle.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class AddVehicle extends StatefulWidget {
  final customer_id;
  final customer_name;
  AddVehicle({Key key, this.customer_id, this.customer_name}) : super(key: key);

  @override
  _AddVehicleState createState() => _AddVehicleState();
}

class _AddVehicleState extends State<AddVehicle> {
  final _vNumber = TextEditingController();
  final _vMake = TextEditingController();
  final _vModel = TextEditingController();
  final _vMyear = TextEditingController();
  final _vCapacity = TextEditingController();
  final _vODO = TextEditingController();
  final _vDescription = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("customer id = " + widget.customer_id);
    print("customer name = " + widget.customer_name);
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
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SingleChildScrollView(child: _buildTextfields(context)),
              ],
            ),
          ),
        ),
        bottomNavigationBar: _buildBottomNavigationBar(context));
  }

  Widget _buildTopAppbar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(130.0),
      child: Container(
        color: Colors.transparent,
        height: MediaQuery.of(context).size.height / 6.0,
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
            height: MediaQuery.of(context).size.height / 4.0,
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
                  "assets/images/add_vehi.png",
                  width: 150,
                  height: 100,
                )),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Center(
                    child: Text(
                      'Vehicle\n     Registration.. ',
                      style: TextStyle(
                          textBaseline: TextBaseline.alphabetic,
                          fontFamily: 'Montserrat',
                          fontSize: 20.0,
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

  Widget _buildTextfields(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin: const EdgeInsets.only(top: 15),
            padding: const EdgeInsets.all(5.0),
            child: Text(
              "Customer Name - " + widget.customer_name,
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 15.0,
                  fontWeight: FontWeight.w900),
            )),
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          // padding: EdgeInsets.only(top: 20),
          child: Column(
            children: <Widget>[
              buildTextfield(context, 'Vehicle Number', Icons.code, _vNumber),
              buildTextfield(context, 'Make', Icons.branding_watermark, _vMake),
              buildTextfield(context, 'Model', Icons.view_module, _vModel),
              buildTextfield(context, 'Manufactured Year',Icons.calendar_view_day, _vMyear),
              buildTextfield(context, 'ODO (Milage)', Icons.timer, _vODO),
              buildTextfield(context, 'Engine Capacity', Icons.tonality, _vCapacity),

              Container(
                width: MediaQuery.of(context).size.width / 1.2,
                height: 70,
                margin: EdgeInsets.only(top: 32),
                padding:
                    EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 5)
                    ]),
                child: TextField(
                  controller: _vDescription,
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.details,
                      color: Colors.grey,
                    ),
                    labelText: 'Discription',
                  ),
                ),
              ),
              // Divider(),
            ],
          ),
        )
      ],
    );
  }

  Widget buildTextfield(BuildContext context, String title, IconData icon,
      TextEditingController controller) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      height: 45,
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 4),
      margin: EdgeInsets.only(top: 32),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(
            icon,
            color: Colors.grey,
          ),
          hintText: title,
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(85.0),
      child: Container(
        color: Colors.transparent,
        height: 85.0,
        alignment: Alignment.center,
        child: _buildSubmitBtn(context),
      ),
    );
  }

  Widget _buildSubmitBtn(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (checkNull()) {
          postVehicleData();
        } else {
          errorDialog('ERROR', 'You should fill all the fields !');
          print("empty fields");
        }
      },
      child: Container(
        height: 45,
        width: MediaQuery.of(context).size.width / 1.2,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF8E8CD8), Color(0xFF8E8CD8)],
            ),
            borderRadius: BorderRadius.all(Radius.circular(50))),
        child: Center(
          child: Text(
            'Submit'.toUpperCase(),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Future<dynamic> errorDialog(String title, String dec) {
    return AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.TOPSLIDE,
            tittle: title,
            desc: dec,
            // btnCancelOnPress: () {},
            btnOkOnPress: () {})
        .show();
  }

  Future<dynamic> successDialog(String title, String dec) {
    return AwesomeDialog(
        context: context,
        dialogType: DialogType.SUCCES,
        animType: AnimType.TOPSLIDE,
        tittle: title,
        desc: dec,
        btnOkText: 'Goto VehicleList !',
        btnCancelText: 'Regsiter Another !',
        btnCancelOnPress: () {},
        btnOkOnPress: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ViewVehicle()));
        }).show();
  }

  postVehicleData() {
    final body = {
      "vnumber": _vNumber.text,
      "make": _vMake.text,
      "model": _vModel.text,
      "m_year": _vMyear.text,
      "odo": _vODO.text,
      "capacity": _vCapacity.text,
      "description": _vDescription.text,
      "cusID": widget.customer_id,
      "cusName": widget.customer_name
    };
    RegisterVehicleService.RegisterVehicle(body).then((success) {
      print(success);
      final _result = success;
      if (_result == "success") {
        clearcontrollers();
        successDialog('Vehicle Registration successfull', 'Click Ok to see !');
      } else {
        errorDialog('ERROR', _result);
      }
    });
  }

  void clearcontrollers() {
    _vNumber.text = '';
    _vMake.text = '';
    _vModel.text = '';
    _vMyear.text = '';
    _vODO.text = '';
    _vCapacity.text = '';
    _vDescription.text = '';
  }

  bool checkNull() {
    if (_vNumber.text == '' ||
        _vMake.text == '' ||
        _vModel.text == '' ||
        _vMyear.text == '' ||
        _vODO.text == '' ||
        _vCapacity.text == '' ||
        _vDescription.text == '') {
      return false;
    } else {
      return true;
    }
  }
}
