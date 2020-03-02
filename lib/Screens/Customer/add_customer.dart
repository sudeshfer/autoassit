import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class AddCustomer extends StatefulWidget {
  AddCustomer({Key key}) : super(key: key);

  @override
  _AddCustomerState createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  
  final _fname = TextEditingController();
  final _lname = TextEditingController();
  final _email = TextEditingController();
  final _tel = TextEditingController();
  final _mobile = TextEditingController();
  get _role => _currentRole;
  final _p_code = TextEditingController();
  final _street = TextEditingController();
  final _city = TextEditingController();
  final _cLimit = TextEditingController();

  List __role = ["Owner", "Driver"];
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentRole;

    @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentRole = _dropDownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String role in __role) {
      items.add(new DropdownMenuItem(value: role, child: new Text(role)));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false, // this avoids the overflow error
      resizeToAvoidBottomInset: true,
       body: SingleChildScrollView(
                child: Column(
           children: <Widget>[
                _buildStack(context),
             SingleChildScrollView(
                child: _buildTextfields(context)
             ),
           ],
         ),
       ),
    );
  }

  Widget _buildStack(BuildContext context){
    return Stack(
         children: <Widget>[
           Positioned(
             child: Container(
               height: MediaQuery.of(context).size.height - 500.0,
               width: MediaQuery.of(context).size.width,
               decoration: BoxDecoration(
                 color: Colors.amber,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(75.0),bottomRight: Radius.circular(75.0)),
               ),
             ),
           )
         ], 
    );
  }

  Widget _buildTextfields(BuildContext context){
    return  Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              //height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 40),
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 45,
                    padding:
                        EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 5)
                        ]),
                    child: TextField(
                      controller: _fname,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.recent_actors,
                          color: Colors.grey,
                        ),
                        hintText: 'First Name',
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 45,
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
                      controller: _lname,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.recent_actors,
                          color: Colors.grey,
                        ),
                        hintText: 'Last Name',
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 45,
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
                      controller: _email,
                      keyboardType: TextInputType.multiline,
                      maxLines: 10,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.email,
                          color: Colors.grey,
                        ),
                        hintText: 'Email',
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 45,
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
                      keyboardType: TextInputType.number,
                      controller: _tel,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.phone,
                          color: Colors.grey,
                        ),
                        hintText: 'Telephone Number',
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 45,
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
                      keyboardType: TextInputType.number,
                      controller: _mobile,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.phone_android,
                          color: Colors.grey,
                        ),
                        hintText: 'Mobile Number',
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 45,
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
                      controller: _cLimit,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.credit_card,
                          color: Colors.grey,
                        ),
                        hintText: 'Credit Limit',
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 15,
                    margin: EdgeInsets.only(top: 32),
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: Text(
                      "Select The Role :",
                      style: TextStyle(
                        color: Color.fromRGBO(143, 148, 251, 1),
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: 40,
                      margin: EdgeInsets.only(top: 25),
                      padding: EdgeInsets.only(left: 16, right: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 5)
                          ]),
                      child: new DropdownButton(
                        value: _currentRole,
                        items: _dropDownMenuItems,
                        onChanged: changedDropDownItem,
                      )),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 15,
                    margin: EdgeInsets.only(top: 32),
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: Text(
                      "Enter The Address :",
                      style: TextStyle(
                        color: Color.fromRGBO(143, 148, 251, 1),
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 45,
                    margin: EdgeInsets.only(top: 25),
                    padding:
                        EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 5)
                        ]),
                    child: TextField(
                      controller: _p_code,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.code,
                          color: Colors.grey,
                        ),
                        hintText: 'Postal Code',
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 45,
                    margin: EdgeInsets.only(top: 25),
                    padding:
                        EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 5)
                        ]),
                    child: TextField(
                      controller: _street,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.streetview,
                          color: Colors.grey,
                        ),
                        hintText: 'Street',
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 45,
                    margin: EdgeInsets.only(top: 25),
                    padding:
                        EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 5)
                        ]),
                    child: TextField(
                      controller: _city,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.location_city,
                          color: Colors.grey,
                        ),
                        hintText: 'City',
                      ),
                    ),
                  ),
                  Divider(),
                  Divider(),
                  InkWell(
                    onTap: () {
                     
                    },
                    child: Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width / 1.2,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFFf45d27), Color(0xFFf5851f)],
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: Center(
                        child: Text(
                          'Submit'.toUpperCase(),
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
  }

  void changedDropDownItem(String selectedRole) {
    setState(() {
      _currentRole = selectedRole;
    });
  }

  void clearcontrollers() {
    _fname.text = '';
    _lname.text = '';
    _email.text = '';
    _tel.text = '';
    _mobile.text = '';
    _p_code.text = '';
    _street.text = '';
    _city.text = '';
    _cLimit.text = '';
  }

  bool checkNull() {
    if (_fname.text == '' ||
        _lname.text == '' ||
        _email.text == '' ||
        _tel.text == '' ||
        _mobile.text == '' ||
        _currentRole == '' ||
        _p_code.text == '' ||
        _street.text == '' ||
        _city.text == '' ||
        _cLimit.text == '') {
      return false;
    } else {
      return true;
    }
  }

}