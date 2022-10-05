import 'dart:convert';
import 'dart:developer';
import 'package:autoassit/Controllers/ApiServices/variables.dart';
import 'package:autoassit/Models/jobModel.dart';
import 'package:autoassit/Providers/JobProvider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CreateJobService {
  static Future<bool> createJob(body,context) async {

    print(body);

     Map<String, String> requestHeaders = {
       'Content-Type': 'application/json'
     };

    final response =
        await http.post('${URLS.BASE_URL}/job/newjob', body: jsonEncode(body) , headers: requestHeaders);

    var data = response.body;
    // print(body);
    print(json.decode(data));

    Map<String, dynamic> res_data = jsonDecode(data);
    log(res_data.toString());

    try{
       if (response.statusCode == 200) {

         Job model = Job.fromJson(res_data);
         Provider.of<JobProvider>(context, listen: false).jobModel = model;
      
      return true;
    } 
    else 
    {
      
      final result = res_data['messege'];
      print(result);
      return false;
    }
    }
    catch(e){
      print(e);
    }
    // return true;
  }
}