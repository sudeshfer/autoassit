import 'package:autoassit/Screens/Customer/Widgets/custom_modal_action_button.dart';
import 'package:autoassit/Screens/Customer/Widgets/custom_textfield.dart';
import 'package:autoassit/Utils/dialogs.dart';
import 'package:flutter/material.dart';

class EditCustomer extends StatefulWidget {
  final fname;
  final lname;
  final email;
  EditCustomer({Key key,this.fname,this.email,this.lname}) : super(key: key);

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
    print("Values set");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
     mainAxisSize: MainAxisSize.min,
     children: <Widget>[
       Center(
           child: Text(
         "Update Customer",
         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
       )),
       SizedBox(
         height: 24,
       ),
       CustomTextField(
           labelText: 'Edit First name', controller: _fname),
       CustomTextField(
           labelText: 'Edit First name', controller: _lname),
       CustomTextField(
           labelText: 'Edit First name', controller: _email),
    
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
    );
  }
}