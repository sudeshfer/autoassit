import 'dart:convert';

import 'package:autoassit/Controllers/ApiServices/variables.dart';
import 'package:autoassit/Models/taskModel.dart';
import 'package:autoassit/Providers/JobProvider.dart';
import 'package:autoassit/Providers/taskProvider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ChangeTaskStatus extends StatefulWidget {
  ChangeTaskStatus({Key key}) : super(key: key);

  @override
  _ChangeTaskStatusState createState() => _ChangeTaskStatusState();
}

class _ChangeTaskStatusState extends State<ChangeTaskStatus> {
  String status = "";
  String comTaskCount = "";
  TaskModel taskmodel;
   ProgressDialog pr;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    taskmodel = Provider.of<TaskProvider>(context, listen: false).taskModel;
    initStatus();
  }

  initStatus() {
    setState(() {
      status = taskmodel.status;
    });
  }

  @override
  Widget build(BuildContext context) {
     pr = new ProgressDialog(context, type: ProgressDialogType.Normal);

    pr.style(
        message: 'changing status...',
        borderRadius: 10.0,
        progressWidget: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/sending.gif'),
                    fit: BoxFit.cover))),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progressTextStyle: TextStyle(fontFamily: 'Montserrat'));

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0, bottom: 20),
          child: Center(
              child: Text(
            "Update Task Status",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
          )),
        ),
        GestureDetector(
          onTap: () {
            initFoodCats("on-Progress");
            print("status is $status");
          },
          child: taskStatus(
            'On-Progress',
            status == "on-Progress"
                ? Icons.radio_button_checked
                : Icons.radio_button_unchecked,
          ),
        ),
        GestureDetector(
          onTap: () {
            initFoodCats("Completed");
            print("status is $status");
          },
          child: taskStatus(
            'Completed',
            status == "Completed"
                ? Icons.radio_button_checked
                : Icons.radio_button_unchecked,
          ),
        ),
        GestureDetector(
          onTap: () {
            initFoodCats("Aborted");
            print("status is $status");
          },
          child: taskStatus(
            'Aborted',
            status == "Aborted"
                ? Icons.radio_button_checked
                : Icons.radio_button_unchecked,
          ),
        ),
        InkWell(
          onTap: () async {
            if (status != "" && status != taskmodel.status) {
              pr.show();
              final body = {
                "_id": taskmodel.taskId, 
                "status": "$status",
                "jobId": taskmodel.jobId
                };

              print(body);

              Map<String, String> requestHeaders = {
                'Content-Type': 'application/json'
              };

              final response = await http.post(
                  '${URLS.BASE_URL}/task/updateTaskStatus',
                  body: jsonEncode(body),
                  headers: requestHeaders);
              print("workingggggggggggg");
              var data = response.body;
              // print(body);
              print(json.decode(data));

              Map<String, dynamic> res_data = jsonDecode(data);

              try {
                if (response.statusCode == 200) {
                  setState(() {
                    taskmodel.status = "$status";
                    comTaskCount = res_data['completeTaskCount'];
                  });
                  Provider.of<TaskProvider>(context, listen: false)
                      .updateTaskStatus("$status");

                  Provider.of<JobProvider>(context, listen: false)
                      .updateComTaskCount("$comTaskCount");
                  print("$status----$comTaskCount");

                  // Provider.of<JobProvider>(context, listen: false).startGetJobs();
                  Provider.of<JobProvider>(context, listen: false).startGetHomeJobss();
                  Provider.of<TaskProvider>(context, listen: false)
                      .startGetTasks(taskmodel.jobId);
                  pr.hide();
                  successDialog("Done", "Status Updated succefully");
                } else {
                  // Dialogs.errorDialog(context, "F", "Something went wrong !");
                  pr.hide();
                  print("job coudlnt create !");
                }
              } catch (e) {
                print(e);
              }
            } else {
              print("doesnt hve to update");
              // Dialogs.errorDialog(context, "Error", "select services & products first !");
              Navigator.of(context).pop();
            }
          },
          child: Container(
            height: MediaQuery.of(context).size.width / 10,
            width: MediaQuery.of(context).size.width / 2,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF8E8CD8), Color(0xFF8E8CD8)],
                ),
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: Center(
              child: Text(
                'Update Status'.toUpperCase(),
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

  initFoodCats(String val) {
    setState(() {
      status = val;
    });
  }

  Future<dynamic> successDialog(String title, String dec) {
    return AwesomeDialog(
        context: context,
        dialogType: DialogType.SUCCES,
        animType: AnimType.TOPSLIDE,
        tittle: title,
        desc: dec,
        // btnCancelOnPress: () {},
        btnOkOnPress: () {
          Navigator.pop(context, taskmodel);
        }).show();
  }

  Widget taskStatus(String task, IconData iconData) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, bottom: 24.0),
      child: Row(children: <Widget>[
        Icon(
          iconData,
          color: Color(0xFFef5350),
          size: 20,
        ),
        SizedBox(
          width: 28,
        ),
        Text(
          task,
          style: TextStyle(
            fontSize: 17,
          ),
        )
      ]),
    );
  }
}
