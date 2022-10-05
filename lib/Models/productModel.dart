class Product {

  String productId;
  String productName;
  String price;
  String amount;
  
  Product({this.productId,this.productName,this.price,this.amount});
 
  // factory Product.fromJson(Map<String, dynamic> json) {
  //   return Product(

  //     productId: json["_id"] as String,
  //     productName: json["proserName"] as String,
  //     price: json["proserCost"] as String,
  //   );
  // }
  Product.fromJson(Map<String, dynamic> json) {
    productId = json['_id'];
    productName = json['proserName'];
    price = json['proserCost'];
    amount = json['productAmount'];
  }

   Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.productId;
    data['proserName'] = this.productName;
    data['proserCost'] = this.price;
    data['productAmount'] = this.amount;
    return data;
  }
}