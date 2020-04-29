import 'package:flutter/material.dart';
import 'package:autoassit/Models/taskModel.dart';

class ChangeTaskStatus extends StatefulWidget {
  ChangeTaskStatus({Key key}) : super(key: key);

  @override
  _ChangeTaskStatusState createState() => _ChangeTaskStatusState();
}

class Task {
  final String task;
  final bool isFinish;
  const Task(this.task, this.isFinish);
}


final List<Task> _taskList = [

   new Task('Full body wash',false),
   new Task('changing break liner', false),
   new Task('tinkering',false),
   new Task('fuel change',false),
   new Task('Oil flter change',true),
   new Task('Oil flter change',true),
];

class _ChangeTaskStatusState extends State<ChangeTaskStatus> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      itemCount: _taskList.length,
      itemBuilder: (context, index){
           return _taskList[index].isFinish

                 ?_taskCompleteList(_taskList[index].task)
                 : _taskListIncomplete(_taskList[index].task);
        //  Divider(
        //    height: 1,
        //  ),
        //  SizedBox(height: 16,),
         
      },
    );
  }

  Widget _taskListIncomplete(String task) {
    return Padding(
           padding: const EdgeInsets.only(left:20.0,bottom: 24.0),
           child: Row(
             children:<Widget>[
               Icon(
                 Icons.radio_button_unchecked,
                 color: Color(0xFFef5350),
                 size: 20,
               ),
               SizedBox(
                 width: 28,
               ),
               Text(task,
                style: TextStyle(
                  fontSize:17,
                ),
               )
             ]
           ),
         );
  }

   Widget _taskCompleteList(String task) {
    return Container(
      foregroundDecoration: BoxDecoration(color: Color(0x60FDFDFD)),
      child: Padding(
             padding: const EdgeInsets.only(left:20.0,top: 20.0),
             child: Row(
               children:<Widget>[
                 Icon(
                   Icons.radio_button_checked,
                   color:Color(0xFFef5350),
                   size: 20,
                 ),
                 SizedBox(
                   width: 28,
                 ),
                 Text(task,
                  style: TextStyle(
                    fontSize:17,
                  ),
                 )
               ]
             ),
           ),
    );
  }
}