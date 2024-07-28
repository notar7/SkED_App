import 'package:flutter/material.dart';
import 'tabbed_sliverlist.dart';

class RegularSchedule extends StatefulWidget {
  RegularSchedule({Key? key}) : super(key: key);

  @override
  State<RegularSchedule> createState() => _RegularScheduleState();
}

class _RegularScheduleState extends State<RegularSchedule> {
  var titles = [
    'Practicals',
    'OFF',
    'Lecture',
    'Lecture',
    'OFF',
    'Lecture',
    'Lecture',
  ];
  var listitems1 = [
    'S1-IOTL\nS2-DSAL\nS3-DSAL\nS4-PBL-II',
    'RECESS',
    'STATISTICS',
    'SOFTWARE ENGINEERING',
    'SHORT BREAK',
    'INTERNET OF THINGS',
    'MANAGEMENT INFORMATION SYSTEM',
  ];

  var listitems2 = [
    'S1-DSAL\nS2-IOTL\nS3-PBL-II\nS4-IOTL',
    'RECESS',
    'INTERNET OF THINGS',
    'INTERNET OF THINGS',
    'SHORT BREAK',
    'DATA STRUCTURES AND ALGORITHMS',
    'SOFTWARE ENGINEERING',
  ];

  var listitems3 = [
    'S1-IOTL\nS2-DSAL\nS3-DSAL\nS4-PBL-II',
    'RECESS',
    'STATISTICS',
    'DATA STRUCTURES AND ALGORITHMS',
    'SHORT BREAK',
    'CODE OF CONDUCT',
    'SOFTWARE ENGINEERING',
  ];

  var listitems4 = [
    'S1-PBL-II\nS2-PBL-II\nS3-PBL-II\nS4-IOTL',
    'RECESS',
    'STATISTICS',
    'MUC',
    'SHORT BREAK',
    'MANAGEMENT INFORMATION SYSTEM',
    'MANAGEMENT INFORMATION SYSTEM',
  ];

  var listitems5 = [
    'S1-DSAL\nS2-PBL-II\nS3-IOTL\nS4-DSAL',
    'RECESS',
    'STATISTICS',
    'DATA STRUCTURES AND ALGORITHMS',
    'SHORT BREAK',
    'AUDIT COURSE-IV',
    'AUDIT COURSE-IV',
  ];

  var listitems6 = [
    'S1-PBL-II\nS2-IOTL\nS3-IOTL\nS4-DSAL',
    'RECESS',
    'STUDENT ACTIVITY',
  ];

  var listitemstime1 = [
    '10:00 am\n\t\t\t\t\tto\n12:00 pm',
    '12:00 pm\n\t\t\t\t\tto\n12:45 pm',
    '12:45 pm\n\t\t\t\t\tto\n\t1:45 pm',
    '\t1:45 pm\n\t\t\t\t\tto\n2:45 pm',
    '2:45 pm\n\t\t\t\t\tto\n3:00 pm',
    '3:00 pm\n\t\t\t\t\tto\n4:00 pm',
    '4:00 pm\n\t\t\t\t\tto\n5:00 pm'
  ];

  var listitemstime2 = [
    '10:00 am\n\t\t\t\t\tto\n12:00 pm',
    '12:00 pm\n\t\t\t\t\tto\n12:15 pm',
    '12:15 pm\n\t\t\t\t\tto\n\t2:15 pm',

  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: TabbedList(
          tabLength: 6,
          sliverTabBar: const SliverTabBar(
              title: const Text('Regular Schedule',style: TextStyle(color: Colors.black),),centerTitle: true,
              backgroundColor: Colors.greenAccent,
              tabBar: TabBar(
                indicatorColor: Colors.blue,
                tabs: [
                  Tab(
                    text: 'Mon',
                  ),
                  Tab(
                    text: 'Tue',
                  ),
                  Tab(
                    text: 'Wed',
                  ),
                  Tab(
                    text: 'Thur',
                  ),
                  Tab(
                    text: 'Fri',
                  ),
                  Tab(
                    text: 'Sat',
                  ),

                ],
              )),
          tabLists: [
            TabListBuilder(
              uniquePageKey: 'page1',
              length: listitems1.length,
              builder: (BuildContext context, index) {
                return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(
                          color: Colors.greenAccent,
                          width: 3,
                        ),
                      ),
                      leading: Container(
                        width: 70.0,
                        height: 70.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.circular(8.0),

                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(listitemstime1[index].toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                      title: Text(titles[index].toString(),style: TextStyle(color: Colors.greenAccent,fontSize: 20,fontWeight: FontWeight.bold),),
                      tileColor: Colors.black,
                      subtitle: Text(listitems1[index].toString(),style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                    ));
              },
              tabListPadding: const EdgeInsets.symmetric(horizontal: 10),
            ),
            TabListBuilder(
              uniquePageKey: 'page2',
              length: listitems2.length,
              builder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(
                          color: Colors.greenAccent,
                          width: 3,
                        ),
                      ),
                      leading: Container(
                        width: 70.0,
                        height: 70.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.circular(8.0),

                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(listitemstime1[index].toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                      title: Text(titles[index].toString(),style: TextStyle(color: Colors.greenAccent,fontSize: 20,fontWeight: FontWeight.bold),),
                      tileColor: Colors.black,
                      subtitle: Text(listitems2[index].toString(),style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                    ));
              },
              tabListPadding: const EdgeInsets.symmetric(horizontal: 10),
            ),
            TabListBuilder(
              uniquePageKey: 'page3',
              length: listitems3.length,
              builder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(
                          color: Colors.greenAccent,
                          width: 3,
                        ),
                      ),
                      leading: Container(
                        width: 70.0,
                        height: 70.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.circular(8.0),

                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(listitemstime1[index].toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                      title: Text(titles[index].toString(),style: TextStyle(color: Colors.greenAccent,fontSize: 20,fontWeight: FontWeight.bold),),
                      tileColor: Colors.black,
                      subtitle: Text(listitems3[index].toString(),style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                    ));
              },
              tabListPadding: const EdgeInsets.symmetric(horizontal: 10),
            ),
            TabListBuilder(
              uniquePageKey: 'page4',
              length: listitems4.length,
              builder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(
                          color: Colors.greenAccent,
                          width: 3,
                        ),
                      ),
                      leading: Container(
                        width: 70.0,
                        height: 70.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.circular(8.0),

                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(listitemstime1[index].toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                      title: Text(titles[index].toString(),style: TextStyle(color: Colors.greenAccent,fontSize: 20,fontWeight: FontWeight.bold),),
                      tileColor: Colors.black,
                      subtitle: Text(listitems4[index].toString(),style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                    ));
              },
              tabListPadding: const EdgeInsets.symmetric(horizontal: 10),
            ),
            TabListBuilder(
              uniquePageKey: 'page5',
              length: listitems5.length,
              builder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(
                          color: Colors.greenAccent,
                          width: 3,
                        ),
                      ),
                      leading: Container(
                        width: 70.0,
                        height: 70.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.circular(8.0),

                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(listitemstime1[index].toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                      title: Text(titles[index].toString(),style: TextStyle(color: Colors.greenAccent,fontSize: 20,fontWeight: FontWeight.bold),),
                      tileColor: Colors.black,
                      subtitle: Text(listitems5[index].toString(),style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                    ));
              },
              tabListPadding: const EdgeInsets.symmetric(horizontal: 10),
            ),
            TabListBuilder(
              uniquePageKey: 'page6',
              length: listitems6.length,
              builder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(
                          color: Colors.greenAccent,
                          width: 3,
                        ),
                      ),
                      leading: Container(
                        width: 70.0,
                        height: 70.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.circular(8.0),

                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(listitemstime2[index].toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                      title: Text(titles[index].toString(),style: TextStyle(color: Colors.greenAccent,fontSize: 20,fontWeight: FontWeight.bold),),
                      tileColor: Colors.black,
                      subtitle: Text(listitems6[index].toString(),style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                    ));
              },
              tabListPadding: const EdgeInsets.symmetric(horizontal: 10),
            )
          ]),
    );
  }
}
