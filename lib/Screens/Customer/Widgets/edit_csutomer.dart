import 'package:autoassit/Screens/Customer/Widgets/custom_modal_action_button.dart';
import 'package:autoassit/Screens/Customer/Widgets/custom_textfield.dart';
import 'package:autoassit/Utils/dialogs.dart';
import 'package:flutter/material.dart';

class EditCustomer extends StatefulWidget {
  final fname;
  final lname;
  final email;
  final tel;
  final mobile;
  final pCode;
  final street;
  final city;
  final cLimit;
  EditCustomer({Key key,
               this.fname,
               this.email,
               this.lname,
               this.tel,
               this.mobile,
               this.pCode,
               this.street,
               this.city,
               this.cLimit}) : super(key: key);

  @override
  _EditCustomerState createState() => _EditCustomerState();
}

class _EditCustomerState extends State<EditCustomer> {
  final _fname = TextEditingController();
  final _lname = TextEditingController();
  final _email = TextEditingController();
  final _tel = TextEditingController();
  final _mobile = TextEditingController();
  // get _role => _currentRole;
  final _p_code = TextEditingController();
  final _street = TextEditingController();
  final _city = TextEditingController();
  final _cLimit = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    assignValues();
  }

  assignValues(){
    _fname.text = widget.fname;
    _lname.text = widget.lname;
    _email.text = widget.email;
    _tel.text = widget.tel;
    _mobile.text = widget.mobile;
    _p_code.text = widget.pCode;
    _street.text = widget.street;
    _city.text = widget.city;
    _cLimit.text = widget.cLimit;
    print("Values set");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/0.2,
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
             height: 20,
           ),
           CustomTextField(
               labelText: 'Edit First name', controller: _fname),
           CustomTextField(
               labelText: 'Edit First name', controller: _lname),
           CustomTextField(
               labelText: 'Edit First Email', controller: _email),
           CustomTextField(
               labelText: 'Edit Telephone', controller: _tel),
               CustomTextField(
               labelText: 'Edit Mobile', controller: _mobile),
               CustomTextField(
               labelText: 'Edit Credit Limit', controller: _cLimit),
               CustomTextField(
               labelText: 'Edit Adress Line 1', controller: _p_code),
               CustomTextField(
               labelText: 'Edit Adress Line 2', controller: _street),
               CustomTextField(
               labelText: 'Edit Adress Line 3', controller: _city),     
    
           CustomModalActionButton(
             onClose: () {
               Navigator.of(context).pop();
             },
             onSave: () {
              Dialogs.successDialog(context, "Done", "Details Updated Successfully !");
             },
           )
     ],
          ),
      ),
    );
  }
}