import 'package:autoassit/Controllers/ApiServices/Job_services/get_products.dart';
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
  List<Service> selectedServices = [];
  List<Service> selectedProducts = [];

  Service _selectedService;

  List<Service> _service = List();
  List<Service> _filteredService = List();

  List<Service> _product = List();
  List<Service> _filteredProduct = List();

  Service _selectedProd;

  @override
  void initState() {
    super.initState();
    GetServicesController.getServices().then((servicesFromServer) {
      setState(() {
        _filteredService = servicesFromServer;
        print("fetched");
      });
    });

    GetProductController.getProducts().then((proFromServer) {
      setState(() {
        _filteredProduct = proFromServer;
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
          DropdownButton<Service>(
            hint: Text("  Select Ref"),
            value: _selectedService,
            onChanged: (Service value) {
              setState(() {
                _selectedService = value;
                selectedServices.add(_selectedService);
              });
              print("--------services-------");
              print(selectedServices.length);
              print("--------services-------");
            },
            items: _filteredService.map((Service val) {
              return DropdownMenuItem<Service>(
                value: val,
                child: Row(
                  children: <Widget>[
                    Text(
                      "  " + val.serviceName,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              );
            }).toList(),
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
