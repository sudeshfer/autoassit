import 'package:autoassit/Providers/AuthProvider.dart';
import 'package:autoassit/Providers/CustomerProvider.dart';
import 'package:autoassit/Providers/JobProvider.dart';
import 'package:autoassit/Providers/VehicleProvider.dart';
import 'package:autoassit/Providers/taskProvider.dart';
import 'package:autoassit/Screens/Customer/add_customer.dart';
import 'package:autoassit/Screens/Customer/pre_cus_list.dart';
import 'package:autoassit/Screens/Customer/view_customer.dart';
import 'package:autoassit/Screens/Jobs/create_job.dart';
import 'package:autoassit/Screens/Login/login_page.dart';
import 'package:autoassit/Screens/Login/pincode_verify.dart';
import 'package:autoassit/Screens/HomePage/home.dart';
import 'package:autoassit/Screens/SplashScreen/splash_screen.dart';
import 'package:autoassit/Screens/Troublelogin/forgotPassword.dart';
import 'package:autoassit/Screens/Vehicle/addVehicle.dart';
import 'package:autoassit/Screens/Vehicle/view_vehicle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:overlay_support/overlay_support.dart';

void main(){
  runApp(OverlaySupport(child: MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => AuthProvider(),
      ),
       ChangeNotifierProvider(
        create: (_) => JobProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => TaskProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => VehicleProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => CustomerProvider(),
      ),
    ],child: MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(primarySwatch: Colors.deepPurple),
      home: new SplashScreen(),
      routes: <String, WidgetBuilder>{
        
        "/login": (BuildContext context) => new LoginPage(),
        "/pincode": (BuildContext context) => new PincodeVerify(),
        "/home": (BuildContext context) => new HomePage(),
        "/forgotpw": (BuildContext context) => new ForgotPassword(),
        "/addCustomer": (BuildContext context) => new AddCustomer(),
        "/addVehicle": (BuildContext context) => new AddVehicle(),
        "/viewCustomer": (BuildContext context) => new ViewCustomer(),
        "/viewVehicle": (BuildContext context) => new ViewVehicle(),
        "/preCusList": (BuildContext context) => new PreCustomerList(),
        "/createJob": (BuildContext context) => new CreateJob(),

       
      },
    );
  }
}