import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:autoassit/Controllers/ApiServices/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginwithOtpService {
  static Future<bool> LoginWithOtp(body) async {

     Map<String, String> requestHeaders = {
       'Content-Type': 'application/json'
     };


    final response =
        await http.post('${URLS.BASE_URL}/user/checkphonenumber', body: jsonEncode(body) , headers: requestHeaders);

    var data = response.body;
    print(body);
    print(json.decode(data));

    Map<String, dynamic> res_data = jsonDecode(data);

    

    if (res_data['loginstatus'] == 'olduser') {
      print(res_data['loginstatus']);
      final _token = res_data['token'];
      final _name = res_data['username'];
      print(_token + _name);
      SharedPreferences login = await SharedPreferences.getInstance();
      login.setString("gettoken", _token);
      login.setString("username", _name);
      return true;
    } 
    else 
    {
      print(res_data['error']);
      return false;
    }
    // return false;
  }
}