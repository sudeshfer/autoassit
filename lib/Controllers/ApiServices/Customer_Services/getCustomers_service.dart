import 'dart:convert';
import 'package:autoassit/Controllers/ApiServices/variables.dart';
import 'package:http/http.dart' as http;
import 'package:autoassit/Models/customerModel.dart';
 
class GetCustomerService {
  static const String url = '${URLS.BASE_URL}/customer/getcustomers';
 
  static Future<List<Customer>> getCustomers() async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<Customer> list = parseCustomers(response.body);
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
 
  static List<Customer> parseCustomers(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Customer>((json) => Customer.fromJson(json)).toList();
  }
}