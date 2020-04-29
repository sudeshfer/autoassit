import 'package:flutter/material.dart';

class AddJobTaskPage extends StatefulWidget {
  AddJobTaskPage({Key key}) : super(key: key);

  @override
  _AddJobTaskPageState createState() => _AddJobTaskPageState();
}

class _AddJobTaskPageState extends State<AddJobTaskPage> {
  double iconSize = 20;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
       padding: const EdgeInsets.all(0),
       itemBuilder: (context, index){
           return Row(
             children: <Widget>[
               Container(
                  //  decoration: IconDecoration(
                  //      iconSize: iconSize,
                  //      lineWidth: 1,
                  //      firstData: true,
                  //      lastData: false
                  //  ),
                                child: Container(
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.all(Radius.circular(50)),
                     boxShadow: [
                       BoxShadow(
                         offset: Offset(0,3),
                         color: Color(0x20000000),
                         blurRadius: 5,
                       )
                     ]
                   ),
                   child: Icon(Icons.fiber_manual_record,
                               size: iconSize,
                               color: Color(0xFFef5350),
                     ),
                 ),
               ),
                 Container(
                   width: 80,
                   child: Padding(
                     padding: const EdgeInsets.only(left:8.0),
                     child: Text('Task 1'),
                   )),
                 Expanded(
                                    child: Padding(
                     padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                     child: Container(
                       padding: const EdgeInsets.all(14.0),
                       decoration: BoxDecoration(
                         color:Colors.white,
                         borderRadius: BorderRadius.all(Radius.circular(12)),
                         boxShadow: [
                             BoxShadow(
                           color: Color(0x20000000),
                           blurRadius: 5,
                           offset: Offset(0, 3)
                         )]
                       ),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children:<Widget>[
                           Text("Full body wash"),
                           SizedBox(
                              height: 12,
                           ),
                           Text("engine oil"),
                         ]
                       ),
                     ),
                   ),
                 )
             ],
           );
       },
       
    );
  }
}

// class IconDecoration extends Decoration {

//   final double iconSize;
//   final double lineWidth;
//   final bool firstData;
//   final bool lastData;

//   IconDecoration({
//     @required double iconSize,
//     @required double lineWidth,
//     @required bool firstData,
//     @required bool lastData,
//   }) : this.iconSize = iconSize,
//        this.lineWidth = lineWidth,
//        this.firstData = firstData,
//        this.lastData = lastData;


//   @override
//   BoxPainter createBoxPainter([onChanged]) {
//     // TODO: implement createBoxPainter
//     return IconLine();
//       }
    
//     }
    
//     class IconLine extends BoxPainter {
     
//   final double iconSize;
//   final bool firstData;
//   final bool lastData;
//   final Paint paintLine;

//   IconLine({
//     @required double iconSize,
//     @required double lineWidth,
//     @required bool firstData,
//     @required bool lastData,

//   }) : this.iconSize = iconSize,
//        this.firstData = firstData,
//        this.lastData = lastData,
//        paintLine = Paint()
//        ..color = Colors.red
//        ..strokeCap = StrokeCap.round
//        ..strokeWidth =  lineWidth;

//   @override
//   void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
//     final leftOffset = Offset(iconSize / 2 , offset.dy);
//     final Offset top = configuration.size.topLeft(Offset(leftOffset.dx, 0.0));
//     final Offset centerTop = configuration.size.centerLeft(Offset(leftOffset.dx, leftOffset.dy));
//     canvas.drawLine(top, centerTop, paint)

//   }
// }