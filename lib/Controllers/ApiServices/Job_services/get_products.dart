import 'dart:convert';
import 'package:autoassit/Controllers/ApiServices/variables.dart';
import 'package:autoassit/Models/productModel.dart';
import 'package:autoassit/Models/servicesModel.dart';
import 'package:http/http.dart' as http;

class GetProductController {
  static const String url = '${URLS.BASE_URL}/proser/getProducts';

  static Future<List<Service>> getProducts() async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<Service> list = parseProducts(response.body);
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<Service> parseProducts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Service>((json) => Service.fromJson(json)).toList();
  }
}
