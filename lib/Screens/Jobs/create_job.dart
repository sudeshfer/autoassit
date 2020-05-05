import 'package:autoassit/Screens/Jobs/Widgets/addTask_page.dart';
import 'package:autoassit/Screens/Jobs/Widgets/add_task_modelbox.dart';
import 'package:autoassit/Screens/Jobs/Widgets/change_task_page.dart';
import 'package:flutter/material.dart';
import 'package:autoassit/Screens/Jobs/Widgets/utils.dart';

class CreateJob extends StatefulWidget {
   final username;
   final vnumber;
   final vehicle_name;
   final customer_name;
  CreateJob({Key key,this.username,this.vnumber,this.vehicle_name,this.customer_name}) : super(key: key);

  @override
  _CreateJobState createState() => _CreateJobState();
}

class _CreateJobState extends State<CreateJob> {

 String currentDate;

 @override
  void initState() {
    // TODO: implement initState
    super.initState();

    currentDate = Utils.getDate();
    print(currentDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body:Stack(
         children:<Widget>[
           Container(
             height: 25 ,
             color:Color(0xFFef5350),
           ),
            _mainContent(context),  
       ]) ,
       floatingActionButton: FloatingActionButton(
         backgroundColor: Color(0xFFef5350),
         onPressed: (){
           showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                    child: AddTaskModel(),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))));
              });
         },
         child: Icon(Icons.add),
         ),
         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: buildBottomAppBar(),
    );
  }

  Widget _mainContent(BuildContext context) {
    return Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: <Widget>[
         SizedBox(
           height: MediaQuery.of(context).size.height / 17.5,
         ),
         _jobDetails(),
         Padding(
           padding: const EdgeInsets.only(left:24.0,right: 24.0,bottom: 24.0),
           child: _buttons(),
         ),
          Expanded(child: AddJobTaskPage())
       ],
     );
  }

  Widget _jobDetails() {
    return Padding(
         padding: const EdgeInsets.all(24.0),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: <Widget>[
             Text("Job NO 1",
             style: TextStyle(
               fontSize:32,
               fontWeight:FontWeight.bold,
               fontFamily: 'Montserrat',
             ),),
             _buildFields('Date - '+ currentDate),
             _buildFields('Vehicle No - ' + widget.vnumber),
             _buildFields('Vehicle Name - ' + widget.vehicle_name),
             _buildFields('Customer Name - ' + widget.customer_name),
             _buildFields('Supervisor Name - ' + widget.username),
             
             
           ],
         ),
       );
  }

  Widget _buildFields(String text){
     return  Text(text,
             style: TextStyle(
               fontSize:12,
               fontWeight:FontWeight.bold,
               fontFamily: 'Montserrat',
             ),);
  }

  

  Widget _buttons() {
    return Row(
           children:<Widget>[
             Expanded(
                              child: MaterialButton(
                 color:Color(0xFFef5350),
                 textColor: Colors.white,
                 onPressed: (){},
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(12)
                 ),
                 padding: const EdgeInsets.all(14.0),
                 child: Text('Add Job Tasks'),
                 ),
             ),
               SizedBox(
                 width: 32,
               ),
                Expanded(
                                    child: MaterialButton(
               color:Colors.white,
               textColor: Color(0xFFef5350),
               onPressed: (){},
               shape: RoundedRectangleBorder(
                   side: BorderSide(color:Color(0xFFef5350)),
                   borderRadius: BorderRadius.circular(12)
               ),
               padding: const EdgeInsets.all(14.0),
               child: Text('Change Task Status'),
               ),
                )
           ]
         );
  }

  BottomAppBar buildBottomAppBar() {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {}
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {}
          )
        ]
      )
    );
  }
}