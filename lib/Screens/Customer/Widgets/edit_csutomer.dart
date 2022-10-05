import 'dart:convert';
import 'package:autoassit/Controllers/ApiServices/variables.dart';
import 'package:autoassit/Models/customerModel.dart';
import 'package:autoassit/Providers/CustomerProvider.dart';
import 'package:autoassit/Screens/Customer/Widgets/custom_modal_action_button.dart';
import 'package:autoassit/Screens/Customer/Widgets/custom_textfield.dart';
import 'package:autoassit/Utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class EditCustomer extends StatefulWidget {
  EditCustomer({Key key}) : super(key: key);

  @override
  _EditCustomerState createState() => _EditCustomerState();
}

class _EditCustomerState extends State<EditCustomer> {
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
  ProgressDialog pr;

  Customer customerModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    customerModel =
        Provider.of<CustomerProvider>(context, listen: false).customerModel;
    assignValues();
    _dropDownMenuItems = getDropDownMenuItems();
    _currentRole = customerModel.role;
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String role in __role) {
      items.add(new DropdownMenuItem(value: role, child: new Text(role)));
    }
    return items;
  }

  assignValues() {
    _fname.text = customerModel.fName;
    _lname.text = customerModel.lName;
    _email.text = customerModel.email;
    _tel.text = customerModel.telephone;
    _mobile.text = customerModel.mobile;
    _p_code.text = customerModel.adL1;
    _street.text = customerModel.adL2;
    _city.text = customerModel.adL3;
    _cLimit.text = customerModel.cLimit;
    print("Values set");
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);

    pr.style(
        message: 'Updating Details...',
        borderRadius: 10.0,
        progressWidget: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/sending.gif'),
                    fit: BoxFit.cover))),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progressTextStyle: TextStyle(fontFamily: 'Montserrat'));

    return Container(
      height: MediaQuery.of(context).size.height / 0.2,
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Center(
                child: Text(
              "Update Customer",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )),
            SizedBox(
              height: 10,
            ),
            CustomTextField(labelText: 'Edit First name', controller: _fname),
            SizedBox(
              height: 10,
            ),
            CustomTextField(labelText: 'Edit First name', controller: _lname),
            SizedBox(
              height: 10,
            ),
            CustomTextField(labelText: 'Edit First Email', controller: _email),
            SizedBox(
              height: 10,
            ),
            CustomTextField(labelText: 'Edit Telephone', controller: _tel),
            SizedBox(
              height: 10,
            ),
            CustomTextField(labelText: 'Edit Mobile', controller: _mobile),
            SizedBox(
             height: 10,
           ),
            CustomTextField(
                labelText: 'Edit Credit Limit', controller: _cLimit),
                SizedBox(
             height: 10,
           ),
            Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 40,
                  margin: EdgeInsets.only(bottom: 15),
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
                   SizedBox(
             height: 10,
           ),
            CustomTextField(
                labelText: 'Edit Adress Line 1', controller: _p_code),
                SizedBox(
             height: 10,
           ),
            CustomTextField(
                labelText: 'Edit Adress Line 2', controller: _street),
                SizedBox(
             height: 10,
           ),
            CustomTextField(labelText: 'Edit Adress Line 3', controller: _city),
            SizedBox(
             height: 10,
           ),
            CustomModalActionButton(
              onClose: () {
                Navigator.of(context).pop();
              },
              onSave: () async {
                pr.show();
                 final body = {
                    "_id": customerModel.cusid,
                    "fname": _fname.text,
                    "lname": _lname.text,
                    "email": _email.text,
                    "telephone": _tel.text,
                    "mobile": _mobile.text,
                    "credit_limit": _cLimit.text,
                    "role": _role,
                    "ad_l1": _p_code.text,
                    "ad_l2": _street.text,
                    "ad_l3": _city.text
                  };

                       Map<String, String> requestHeaders = {
                      'Content-Type': 'application/json'
                    };
                          final response = await http.post(
                        '${URLS.BASE_URL}/customer/updateCustomer',
                        body: jsonEncode(body),
                        headers: requestHeaders);
                    print("workingggggggggggg");
                    var data = response.body;
                    // print(body);
                    print(json.decode(data));
                  
                    Map<String, dynamic> res_data = jsonDecode(data);
                     try {
                      if (response.statusCode == 200) {
                        setState(() {
                          customerModel.fName = _fname.text;
                          customerModel.lName =  _lname.text;
                          customerModel.email = _email.text;
                          customerModel.telephone = _tel.text;
                          customerModel.mobile = _mobile.text;
                          customerModel.cLimit = _cLimit.text;
                          customerModel.role = _role;
                          customerModel.adL1 = _p_code.text;
                          customerModel.adL2 = _street.text;
                          customerModel.adL3 = _city.text;
                        });
                        // Provider.of<VehicleProvider>(context, listen: false)
                        //     .updateODO("${milage.text}");
                  
                        // print("${vehicleModel.odo}}");
                        pr.hide();
                        Dialogs.successDialog(
                            context, "Done", "details Updated succefully");
                      } else {
                        // Dialogs.errorDialog(context, "F", "Something went wrong !");
                        pr.hide();
                        print("ODO coudlnt update !");
                      }
                    }  catch (e) {
                        print(e);
                      }
      
              },
            )
          ],
        ),
      ),
    );
  }

  void changedDropDownItem(String selectedRole) {
    setState(() {
      _currentRole = selectedRole;
    });
  }
}
