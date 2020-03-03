class Vehicle {

  String vNumber;
  String make;
  String model;
  String mYear;
  String odo;
  String eCapacity;
  String desc;
  
 
  Vehicle({this.vNumber,this.make,this.model,this.mYear,this.odo,this.eCapacity,this.desc});
 
  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(

      vNumber: json["vnumber"] as String,
      make: json["make"] as String,
      model: json["model"] as String,
      mYear: json["m_year"] as String,
      odo: json["odo"] as String,
      eCapacity: json["capacity"] as String,
      desc: json["description"] as String,
    );
  }
}