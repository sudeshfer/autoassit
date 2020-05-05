class Service {

  String serviceId;
  String serviceName;
  String price;
  
  Service({this.serviceId,this.serviceName,this.price});
 
  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(

      serviceId: json["_id"] as String,
      serviceName: json["proserName"] as String,
      price: json["proserCost"] as String,
    );
  }
}