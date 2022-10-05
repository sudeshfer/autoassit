import 'package:autoassit/Models/productModel.dart';
import 'package:autoassit/Models/servicesModel.dart';
import 'package:flutter/foundation.dart';

class TaskModel with ChangeNotifier{
  String taskId;
  String jobId;
  String jobno;
  String date;
  String vNumber;
  String vName;
  String cusId;
  String cusName;
  String procerCharge;
  String labourCharge;
  String total;
  String status;
  List<ServiceModel> services;
  List<ProductModel> products;  
  String garageId;
  String garageName;
  String supervisorName;

  TaskModel(
      {this.taskId,
      this.jobId,
      this.jobno,
      this.date,
      this.vNumber,
      this.vName,
      this.cusId,
      this.cusName,
      this.procerCharge,
      this.labourCharge,
      this.total,
      this.status,
      this.services,
      this.products,
      this.garageId,
      this.garageName,
      this.supervisorName
});

TaskModel.fromJson(Map<String, dynamic> map)
      :  taskId= map["_id"],
      jobId= map["jobId"],
      jobno= map["jobNo"],
      date= map["date"],
      vNumber= map["vnumber"],
      vName= map["vName"],
      cusId= map["cusId"],
      cusName= map["cusName"],
      total= map["total"],
      procerCharge= map["procerCharge"],
      labourCharge= map["labourCharge"],
      status= map["status"],
      services = (map['services'] as List)
            ?.map((i) => ServiceModel.fromJson(i))
            ?.toList(),
      products = (map['products'] as List)
            ?.map((i) => ProductModel.fromJson(i))
            ?.toList(),
      garageId= map["garageId"],
      garageName= map["garageName"],
      supervisorName= map["supervisorName"];

}

class ServiceModel {

  String serviceId;
  String serviceName;
  String price;
  String labourCharge;
  
  ServiceModel({this.serviceId,this.serviceName,this.price,this.labourCharge});
 
  // factory ServiceModel.fromJson(Map<String, dynamic> json) {
  //   return ServiceModel(

  //     serviceId: json["_id"] as String,
  //     serviceName: json["proserName"] as String,
  //     price: json["proserCost"] as String,
  //   );
  // }

    ServiceModel.fromJson(Map<String, dynamic> json) {
    serviceId = json['_id'];
    serviceName = json['serviceName'];
    price = json['serviceCost'];
    labourCharge = json['labourCharge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.serviceId;
    data['serviceName'] = this.serviceName;
    data['serviceCost'] = this.price;
    data['labourCharge'] = this.labourCharge;
    return data;
  }
}

class ProductModel {

  String productId;
  String productName;
  String price;
  String amount;
  
  ProductModel({this.productId,this.productName,this.price,this.amount});
 
  // factory ProductModel.fromJson(Map<String, dynamic> json) {
  //   return ProductModel(

  //     productId: json["_id"] as String,
  //     productName: json["proserName"] as String,
  //     price: json["proserCost"] as String,
  //   );
  // }
  ProductModel.fromJson(Map<String, dynamic> json) {
    productId = json['_id'];
    productName = json['productName'];
    price = json['productCost'];
    amount = json['productAmount'];
  }

   Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.productId;
    data['productName'] = this.productName;
    data['productCost'] = this.price;
    data['productAmount'] = this.amount;
    return data;
  }
}