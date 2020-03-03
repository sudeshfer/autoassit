import 'dart:convert';
import 'package:autoassit/Controllers/ApiServices/variables.dart';
import 'package:http/http.dart' as http;
import 'package:autoassit/Models/vehicleModel.dart';

class GetVehicleService {
  static const String url = '${URLS.BASE_URL}/vehicle/getvehicles';

  static Future<List<Vehicle>> getVehicles() async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<Vehicle> list = parseVehicles(response.body);
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<Vehicle> parseVehicles(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Vehicle>((json) => Vehicle.fromJson(json)).toList();
  }
}
