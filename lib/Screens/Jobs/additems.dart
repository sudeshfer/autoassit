import 'package:autoassit/Controllers/ApiServices/Job_services/get_products.dart';
import 'package:autoassit/Controllers/ApiServices/Job_services/get_services.dart';
import 'package:autoassit/Models/servicesModel.dart';
import 'package:autoassit/Screens/Jobs/Widgets/custom_modal_action_button.dart';
import 'package:autoassit/Utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class AddItemsPage extends StatefulWidget {
  AddItemsPage({Key key}) : super(key: key);

  @override
  _AddItemsPageState createState() => _AddItemsPageState();
}

class _AddItemsPageState extends State<AddItemsPage> {
  List<Service> selectedServices = [];
  List<Service> selectedProducts = [];

  Service _selectedService;

  List<Service> _service = List();
  List<Service> _filteredService = List();

  List serviceIndexes = [];

  List<Service> _product = List();
  List<Service> _filteredProduct = List();

  Service _selectedProd;

  List prodIndexes = [];

  final quantityController = TextEditingController();

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
    return Scaffold(
      resizeToAvoidBottomPadding: false, // this avoids the overflow error
        resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
              child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top:25.0),
                child: Center(
                    child: Text(
                  "Add new Job task",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                )),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.2,
                height: 15,
                margin: EdgeInsets.only(top: 32),
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Text(
                  "Select the service :",
                  style: TextStyle(
                    color: Color.fromRGBO(143, 148, 251, 1),
                    fontSize: 17,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(12)
                ),
                width: MediaQuery.of(context).size.width / 1.5,
                child: DropdownButton<Service>(
                  hint: Text("  Select Service",),
                  value: _selectedService,
                  onChanged: (Service value) {
                    setState(() {
                      _selectedService = value;
                      // selectedServices.add(_selectedService);
                    });
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
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color:Color(0xFFef5350),
                  borderRadius: BorderRadius.circular(12),
                ),
                width: MediaQuery.of(context).size.width / 2.5,
                child: InkWell(
                  onTap: () {
                    final saleitm = {
                      "serviceName": _selectedService.serviceName,
                      "serviceCost": _selectedService.price
                    };
                    serviceIndexes.add(saleitm);
                    print("--------services-------");
                    print(serviceIndexes);
                    print("--------services-------");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[Text("Save Service", style: TextStyle(color:Colors.white))],
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.2,
                height: 15,
                // margin: EdgeInsets.only(top: 32),
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Text(
                  "Select the product :",
                  style: TextStyle(
                    color: Color.fromRGBO(143, 148, 251, 1),
                    fontSize: 17,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.5,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(12)
                ),
                child: DropdownButton<Service>(
                  hint: Text("  Select Product",),
                  value: _selectedProd,
                  onChanged: (Service value) {
                    setState(() {
                      _selectedProd = value;
                      // selectedServices.add(_selectedService);
                    });
                  },
                  items: _filteredProduct.map((Service prod) {
                    return DropdownMenuItem<Service>(
                      value: prod,
                      child: Row(
                        children: <Widget>[
                          Text(
                            "  " + prod.serviceName,
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.5,
                height: MediaQuery.of(context).size.height / 14,
                child: TextFormField(
                  controller: quantityController,
                  decoration: new InputDecoration(
                    labelText: "Product Quantity",
                    fillColor: Colors.amber,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(12.0),
                      borderSide: new BorderSide(),
                    ),
                    //fillColor: Colors.green
                  ),
                  keyboardType: TextInputType.number,
                  style: new TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color:Color(0xFFef5350),
                  borderRadius: BorderRadius.circular(12),
                ),
                width: MediaQuery.of(context).size.width / 2.5,
                child: InkWell(
                  onTap: () {
                    final proditm = {
                      "productName": _selectedProd.serviceName,
                      "productAmount": quantityController.text,
                      "productCost": _selectedProd.price
                    };
                    prodIndexes.add(proditm);
                    print("--------services-------");
                    print(prodIndexes);
                    print("--------services-------");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[Text("Save Product", style: TextStyle(color:Colors.white))],
                  ),
                ),
              ),
              SizedBox(
                height: 34,
              ),
              InkWell(
                  onTap: () {
                    final body = {
                      // "services": serviceIndexes,
                      // "products": prodIndexes,
                      // "date": DateTime.now(),
                      // "vnumber": "cscsd",
                      // "vName": "csdc",
                      // "cusId": "csds",
                      // "cusName": "csdcsd",
                      // "total": "csdcsd",
                      // "status": "csdcsd"
                      Dialogs.successDialog(context, "Done", "Job Created Successfully !")
                    };

                    print(body);
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
            'Create job'.toUpperCase(),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),)
            ],
          ),
        ),
      ),
    );
  }
}
