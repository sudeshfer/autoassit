import 'package:autoassit/Controllers/ApiServices/Job_services/get_services.dart';
import 'package:autoassit/Models/servicesModel.dart';
import 'package:autoassit/Screens/Jobs/Widgets/custom_modal_action_button.dart';
import 'package:autoassit/Utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class AddTaskModel extends StatefulWidget {
  AddTaskModel({Key key}) : super(key: key);

  @override
  _AddTaskModelState createState() => _AddTaskModelState();
}

class _AddTaskModelState extends State<AddTaskModel> {
  List<int> selectedServices = [];
  List<int> selectedProducts = [];
  final List<DropdownMenuItem> services = [];
  final List<DropdownMenuItem> products = [];

  List<Service> service = List();

  @override
  void initState() {
    super.initState();
    GetServicesController.getServices().then((servicesFromServer) {
      setState(() {
        service = servicesFromServer;
        print("fetched");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
                child: Text(
              "Add new Job task",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )),
            SizedBox(
              height: 24,
            ),
             SearchableDropdown.multiple(
        items: services,
        selectedItems: selectedServices,
        hint: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text("Select Service"),
        ),
        searchHint: "Select Service",
        onChanged: (value) {
          setState(() {
            selectedServices = value;
          });
        },
        closeButton: (selectedServices) {
          return (selectedServices.isNotEmpty
              ? "Save ${selectedServices.length == 1 ? '"' + services[selectedServices.first].value.toString() + '"' : '(' + selectedServices.length.toString() + ')'}"
              : "Save without selection");
        },
        isExpanded: true,
      ),
      SearchableDropdown.multiple(
        items: products,
        selectedItems: selectedProducts,
        hint: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text("Select Product"),
        ),
        searchHint: "Select Product",
        onChanged: (value) {
          setState(() {
            selectedProducts = value;
          });
        },
        closeButton: (selectedProducts) {
          return (selectedProducts.isNotEmpty
              ? "Save ${selectedProducts.length == 1 ? '"' + products[selectedProducts.first].value.toString() + '"' : '(' + selectedProducts.length.toString() + ')'}"
              : "Save without selection");
        },
        isExpanded: true,
      ),
      SizedBox(
              height: 24,
            ),
      CustomModalActionButton(
             onClose: () {
               Navigator.of(context).pop();
             },
             onSave: () {
              Dialogs.successDialog(context, "Done", "Job created !");
             },
           )
        ],
      ),
    );
  }
}