import 'dart:convert';
import 'dart:developer';
import 'package:autoassit/Controllers/ApiServices/variables.dart';
import 'package:http/http.dart' as http;

class RegisterCustomerService {
  static Future<String> RegisterCustomer(body) async {

    print(body);

     Map<String, String> requestHeaders = {
       'Content-Type': 'application/json'
     };


    final response =
        await http.post('${URLS.BASE_URL}/customer/newcustomer', body: jsonEncode(body) , headers: requestHeaders);

    var data = response.body;
    // print(body);
    print(json.decode(data));

    Map<String, dynamic> res_data = jsonDecode(data);
    log(res_data.toString());

    if (res_data['status'] == 'success') {

      final result = res_data['status'];
      
      return result;
    } 
    else 
    {
      
      final result = res_data['error'];
      print(result);
      return result;
    }
    // return true;
  }
}