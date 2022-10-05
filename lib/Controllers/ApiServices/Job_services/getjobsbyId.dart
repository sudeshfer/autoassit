import 'dart:convert';
import 'package:autoassit/Controllers/ApiServices/variables.dart';
import 'package:autoassit/Models/jobModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GetJobsByIdService {
  static Future<List<dynamic>> getJobsById() async {
    try {
      Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
      
      SharedPreferences jobs = await SharedPreferences.getInstance();
      final _id = jobs.getString("jobid");
      print("id is got"+_id);
      
      final body = {
        "_id": jobs.getString("jobid")
      };

      final response = await http.post('${URLS.BASE_URL}/job/getjobsByJobId',
          body: jsonEncode(body), headers: requestHeaders);

      if (response.statusCode == 200) {
        List<Job> list = parseJobs(response.body);
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<Job> parseJobs(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Job>((json) => Job.fromJson(json)).toList();
  }
}
