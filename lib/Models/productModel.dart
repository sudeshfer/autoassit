class Product {

  String serviceId;
  String serviceName;
  String price;
  
  Product({this.serviceId,this.serviceName,this.price});
 
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(

      serviceId: json["_id"] as String,
      serviceName: json["proserName"] as String,
      price: json["proserCost"] as String,
    );
  }
}