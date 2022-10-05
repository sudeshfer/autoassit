import 'package:autoassit/Controllers/ApiServices/Job_services/get_products.dart';
import 'package:autoassit/Controllers/ApiServices/Job_services/get_services.dart';
import 'package:autoassit/Controllers/ApiServices/variables.dart';
import 'package:autoassit/Models/jobModel.dart';
import 'package:autoassit/Models/productModel.dart';
import 'package:autoassit/Models/servicesModel.dart';
import 'package:autoassit/Models/userModel.dart';
import 'package:autoassit/Providers/AuthProvider.dart';
import 'package:autoassit/Providers/JobProvider.dart';
import 'package:autoassit/Providers/taskProvider.dart';
import 'package:autoassit/Utils/dialogs.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddTasksModel extends StatefulWidget {
  final username;
  final vnumber;
  final vehicle_name;
  final customer_name;
  final cusId;
  String jobTot;
  String taskCount;
  Job jobmodel;

  AddTasksModel({Key key, this.username,
      this.vnumber,
      this.vehicle_name,
      this.customer_name,this.cusId,
      this.jobTot,this.taskCount,this.jobmodel}) : super(key: key);

  @override
  _AddTasksModelState createState() => _AddTasksModelState();
}

class _AddTasksModelState extends State<AddTasksModel> {
  // List<Service> selectedServices = [];
  // List<Service> selectedProducts = [];

  Service _selectedService;

  List<Service> _service = List();
  List<Service> _filteredService = List();

  List serviceIndexes = [];

  List<Product> _product = List();
  List<Product> _filteredProduct = List();

  Product _selectedProd;

  List prodIndexes = [];
  List __proAmount = ["1","2","3","4","5","6","7","8","9","10"];
  String _currentAmount;
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  get _amount => _currentAmount;

  final quantityController = TextEditingController();

  SharedPreferences login;
  ProgressDialog pr;
  Job jobModel;
  UserModel userModel;

  int jobno = 1;
  int jobval;
  double procerCharge = 0;
  double labourCharge = 0;
  double fullTaskCharge = 0;
  double jobtot = 0;
  double jobProcerCharge = 0;
  double joblabourCharge = 0;
  int taskCount = 0;

  @override
  void initState() {
    super.initState();
   getProductsServices();
   userModel = Provider.of<AuthProvider>(context, listen: false).userModel;
   jobModel = Provider.of<JobProvider>(context, listen: false).jobModel;
   _dropDownMenuItems = getDropDownMenuItems();
   _currentAmount = _dropDownMenuItems[0].value;
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String amount in __proAmount) {
      items.add(new DropdownMenuItem(value: amount, child: new Text(amount)));
    }
    return items;
  }
  
  getProductsServices(){
     
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

Future<bool> onbackpress(){
 Navigator.pop(context,jobModel);
}

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);

    pr.style(
        message: 'addind task..',
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

    return WillPopScope(
      onWillPop:  onbackpress,
          child: Container(
        child: SingleChildScrollView(
                child: Padding(
            padding: const EdgeInsets.only(right:20.0,left:20.0,bottom:20.0,top: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // Align(
                //   alignment: Alignment.topRight,
                //                 child: IconButton(icon: Icon(Icons.close,
                //                  color: Colors.red,  
                //   ), onPressed: (){
                //     Navigator.of(context).pop();
                //   }),
                // ),
                Padding(
                  padding: const EdgeInsets.only(top:10.0),
                  child: Center(
                      child: Text(
                    "Add new Job task",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  )),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
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
                  height: MediaQuery.of(context).size.height / 70,
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
                      serviceIndexes.clear();
                      setState(() {
                        _selectedService = value;
                        // selectedServices.add(_selectedService);
                      });

                      iniServices();
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
                  width: MediaQuery.of(context).size.width / 1.2,
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
                  child: DropdownButton<Product>(
                    hint: Text("  Select Product",),
                    value: _selectedProd,
                    onChanged: (Product value) {
                      setState(() {
                        _selectedProd = value;
                        // selectedServices.add(_selectedService);
                      });
                    },
                    items: _filteredProduct.map((Product prod) {
                      return DropdownMenuItem<Product>(
                        value: prod,
                        child: Row(
                          children: <Widget>[
                            Text(
                              "  " + prod.productName,
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                 SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  // margin: EdgeInsets.only(top: 32),
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Text(
                    "Select product amount :",
                    style: TextStyle(
                      color: Color.fromRGBO(143, 148, 251, 1),
                      fontSize: 17,
                    ),
                  ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 40,
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.only(left: 16, right: 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 5)
                        ]),
                    child: new DropdownButton(
                      value: _currentAmount,
                      items: _dropDownMenuItems,
                      onChanged: changedDropDownItem,
                    )),
               
                SizedBox(
                  height: 15,
                ),
                InkWell(
                    onTap: () async {
                         print("working");
                         if(serviceIndexes.isNotEmpty && prodIndexes.isNotEmpty){
                           pr.show();
                                final body = {
                            "jobId": jobModel.jobId,
                            "jobNo": jobModel.jobno,
                            "date": DateTime.now().toString(),
                            "vnumber": jobModel.vNumber,
                            "vName": jobModel.vName,
                            "cusId": jobModel.cusId,
                            "cusName": jobModel.cusName,
                            "procerCharge": procerCharge.toString(),
                            "labourCharge": "$labourCharge",
                            "total": "$fullTaskCharge",
                            "status": "on-Progress",
                            "services": serviceIndexes,
                            "products": prodIndexes,
                            "token": userModel.token
                          };

                          print(body);

                          Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

                          final response = await http.post('${URLS.BASE_URL}/task/newtask',
                              body: jsonEncode(body), headers: requestHeaders);
                          print("workingggggggggggg");
                          var data = response.body;
                          // print(body);
                          print(json.decode(data));

                          Map<String, dynamic> res_data = jsonDecode(data);

                          try {
                            if (response.statusCode == 200) {
                              // clearcontrollers();
                             
                              // jobModel = Job.fromJson(res_data);
                              
                              setState(() {
                              double totnow = double.parse(jobModel.total);
                              int taskCountnw = int.parse(jobModel.taskCount);
                              double procer = double.parse(jobModel.procerCharge);
                              double labour = double.parse(jobModel.labourCharge);
                              jobtot = totnow + fullTaskCharge;
                              taskCount = taskCountnw + 1;
                              jobProcerCharge = procer + procerCharge;
                              joblabourCharge = labour + labourCharge;
                              jobModel.taskCount = taskCount.toString();
                              jobModel.total = jobtot.toString();
                              jobModel.procerCharge = jobProcerCharge.toString();
                              jobModel.labourCharge = joblabourCharge.toString();
                              }); 
                              Provider.of<JobProvider>(context, listen: false).updateTaskCountAndJobtot("$taskCount", "$jobtot");
                              print("$taskCount----$jobtot");
                             
                              // Provider.of<JobProvider>(context, listen: false).startGetJobs();
                              Provider.of<JobProvider>(context, listen: false).startGetHomeJobss();
                              Provider.of<TaskProvider>(context, listen: false).startGetTasks(jobModel.jobId);
                              pr.hide();
                               successDialog("Done", "Task added succefully");
                   
                            } else {
                              // Dialogs.errorDialog(context, "F", "Something went wrong !");
                              pr.hide();
                              print("job coudlnt create !");
                              
                            }
                          } catch (e) {
                            print(e);
                          }
                         }else{
                           print("empty");
                            Dialogs.errorDialog(context, "Error", "select services & products first !");
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
              'Add Task'.toUpperCase(),
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> successDialog(String title, String dec) {
    return AwesomeDialog(
            context: context,
            dialogType: DialogType.SUCCES,
            animType: AnimType.TOPSLIDE,
            tittle: title,
            desc: dec,
            // btnCancelOnPress: () {},
            btnOkOnPress: () {
               Navigator.pop(context,jobModel);
            })
        .show();
  }

  void iniServices() {
    final saleitm = {
      "serviceName": _selectedService.serviceName,
      "serviceCost": _selectedService.price,
      "labourCharge": _selectedService.labourCharge
    };
    serviceIndexes.add(saleitm);
    setState(() {
      labourCharge = double.parse(_selectedService.labourCharge);
      procerCharge = procerCharge + double.parse(_selectedService.price);
      fullTaskCharge = procerCharge + labourCharge;
    });
    
    print("--------services-------");
    print(serviceIndexes);
    print("$procerCharge --- $labourCharge --- full tot $fullTaskCharge");
    print("--------services-------");
  }

  void changedDropDownItem(String selectedRole) {
    if(_selectedProd != null){
        setState(() {
      _currentAmount = selectedRole;
    });
    print(_currentAmount);
    print("not null");
    iniProcersAndTotal();
    }else{
      Dialogs.errorDialog(context, "error", "Select some products first !");
    }
   
  }

  void iniProcersAndTotal() {
     final proditm = {
                      "productName": _selectedProd.productName,
                      "productAmount": _currentAmount,
                      "productCost": _selectedProd.price
                    };
                    prodIndexes.add(proditm);
                    double temp = double.parse(_selectedProd.price);
                    double totProcer = temp* int.parse(_currentAmount);
                    setState(() {
                      procerCharge = procerCharge + totProcer;
                      fullTaskCharge = procerCharge + labourCharge;
                    });
                    print("--------products-------");
                    print(prodIndexes);
                    print("$procerCharge --- $labourCharge --- full tot $fullTaskCharge");
                    print("--------products-------");
  }
}
