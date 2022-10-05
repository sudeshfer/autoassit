import 'dart:convert';
import 'package:autoassit/Controllers/ApiServices/variables.dart';
import 'package:autoassit/Models/userModel.dart';
import 'package:autoassit/Providers/AuthProvider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerifyEmailService {
  static Future<bool> VerifyEmail(body,context) async {

     Map<String, String> requestHeaders = {
       'Content-Type': 'application/json'
     };


    final response =
        await http.post('${URLS.BASE_URL}/mail/verifyemail', body: jsonEncode(body) , headers: requestHeaders);

    var data = response.body;
    // print(body);
    print(json.decode(data));

    Map<String, dynamic> res_data = jsonDecode(data);
    // log(res_data['loginstatus']);
    if (response.statusCode == 200) {
      UserModel myModel = UserModel.fromJson(res_data);
      //make my model usable to all widgets
      Provider.of<AuthProvider>(context, listen: false).userModel = myModel;
      SharedPreferences login = await SharedPreferences.getInstance();
      login.setString("authtoken", myModel.token);
      return true;
    } else {
      return false;
    }
    // return false;
  }
}