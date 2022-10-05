import 'dart:async';
import 'package:autoassit/Models/jobModel.dart';
import 'package:autoassit/Providers/JobProvider.dart';
import 'package:autoassit/Screens/HomePage/homeWidgets/progress_indicator.dart';
import 'package:autoassit/Screens/Jobs/showJob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skeleton/flutter_skeleton.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import 'package:timeago/timeago.dart' as timeAgo;

class FinishedJobList extends StatefulWidget {
  @override
  _FinishedJobListState createState() => _FinishedJobListState();
}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class _FinishedJobListState extends State<FinishedJobList> {
  final _debouncer = Debouncer(milliseconds: 500);
  List<Job> job = List();
  List<Job> jobList = List();
  bool isfetching = true;
  bool isEmpty = false;
  Job jobmodel;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    getFinishedJobs();
    
    _scrollController = ScrollController();
  }

  getFinishedJobs() {
    Provider.of<JobProvider>(context, listen: false).startGetFinishedJobs().then((jobsFromserver){

        if (jobsFromserver.isNotEmpty) {
      setState(() {
        job = jobsFromserver;
        jobList = job;
        isfetching = false;
        isEmpty = false;
      });
    }else{
      setState(() {
        isfetching = false;
        isEmpty = true;
      });
    }   
    });
  }

  final List colors = [Colors.blue, Colors.black, Colors.green];

  @override
  Widget build(BuildContext context) {
  
    return Column(
      children: [
        _bodyContent(context)
      ],
    );
  }

  Widget _bodyContent(BuildContext contect){
    //   _jobList = [];
    // _jobList = Provider.of<JobProvider>(context).listJobsFinished;
    // if (_jobList.isNotEmpty) {
    //   setState(() {
    //     isfetching = false;
    //     isEmpty = false;
    //   });
    // }else{
    //   setState(() {
    //     isfetching = false;
    //     isEmpty = true;
    //   });
    // }

    var rng = new math.Random.secure();
    return  isfetching
            ? 
            SizedBox(
              height: MediaQuery.of(context).size.height,
                      child: ListSkeleton(
                  style: SkeletonStyle(
                    theme: SkeletonTheme.Light,
                    isShowAvatar: false,
                    isCircleAvatar: false,
                    barCount: 3,
                    // colors: [Color(0xFF8E8CD8), Color(0xFF81C784), Color(0xffFFE082)],
                    isAnimation: true
                  ),
                ),
            )
            : isEmpty ? Text("No Finished jobs"): Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildSearchBar(contect),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: jobList.length,
                    controller: _scrollController,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      var date = DateTime.parse(jobList[index].date);
                      int progressVal = progressCounter(index);
                      return Card(
                        // color: Colors.grey[200],
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: GestureDetector(
                          onTap: () async {
                            // final jobid = _jobList[index].jobId;
                            jobmodel = jobList[index];
                            Provider.of<JobProvider>(context, listen: false).jobModel = jobmodel;
                            print(jobmodel.jobno);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ShowJob()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Container(
                                    child: Center(
                                      child: Text(
                                        "Job No ${jobList[index].jobno}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 20),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: new BorderRadius.circular(8.0),
                                        color: colors[rng.nextInt(3)]),
                                    width: 70.0,
                                    height: 80.0,
                                  ),
                                  title: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          Icon(Icons.directions_car,
                                          size: 20,
                                            color: Color(0xFFef5350),
                                          ),
                                           SizedBox(
                                        width: 5,
                                      ),
                                          Text(
                                            "${jobList[index].vName} ${jobList[index].vNumber}",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 18,
                                                fontFamily: "SF"),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: [
                                              Icon(Icons.person_pin,
                                              size: 20,
                                            color: Color(0xFFef5350),
                                          ),
                                           SizedBox(
                                        width: 5,
                                      ),
                                              Text(
                                                "Mr.${jobList[index].cusName}",
                                                style: TextStyle(
                                                    color: Colors.blueAccent,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "${jobList[index].taskCount} Tasks / ${jobList[index].completeTaskCount} Done",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.green[700],
                                              fontWeight: FontWeight.w500
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      FAProgressBar(
                                        size: 4,
                                        currentValue: progressVal,
                                        progressColor: Colors.green,
                                        backgroundColor: Color(0xffF0F0F0),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                          height: MediaQuery.of(context).size.height /60,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              // color: Colors.amber,
                              width: MediaQuery.of(context).size.width /2.3,
                              child: Text("Job Started ${timeAgo.format(date)}",
                                 style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 15,
                        ),
                              )),
                            Container(
                              // margin: EdgeInsets.only(left:3),
                              height: MediaQuery.of(context).size.height /20,
                              width: MediaQuery.of(context).size.width /3,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('assets/images/completed2.png'),
                                      fit: BoxFit.fill))),
                          ],
                        ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ],
            );
  }

  int progressCounter(int index) {
    int temp = int.parse(jobList[index].completeTaskCount);
    int tcount = int.parse(jobList[index].taskCount);
    if(tcount != 0){
      int progressVal = (100 ~/ tcount) * temp ;
      return progressVal;
    }else{
      int progressVal = 0;
      return progressVal;
    }
    
    
  }

     Widget _buildSearchBar(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(right: 30.0),
      width: MediaQuery.of(context).size.width / 1.2,
      height: 45,
      // margin: EdgeInsets.only(top: 32),
      padding: EdgeInsets.only(top: 2, left: 16, right: 16, bottom: 2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 7)]),
      child: TextField(
        keyboardType: TextInputType.text,
        // controller: _search,
        // onTap: () {
        //   setState(() {
        //     isSearchFocused = true;
        //   });
        // },
        onChanged: (string) {
          _debouncer.run(() {
            setState(() {
              jobList = job
                  .where((u) =>
                      (u.vNumber.toLowerCase().contains(string.toLowerCase())))
                  .toList();
            });
          });
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey,
            size: 30,
          ),
          hintText: 'Search Completed Jobs',
        ),
      ),
    );
  }
}
