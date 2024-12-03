import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Server_conn/mariaDB_server.dart';
import 'package:project_2/time/time_model.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:project_2/time/addTimeTable.dart';

class TimeTable extends StatefulWidget {
  const TimeTable({super.key});

  @override
  State<TimeTable> createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  List<TimeModel> myTimes = [];

  void waitForMyTimes() async {
    myTimes = await mariaDB_server().loabbyUser();
    setState(() {});
  }

  int todayWeek = DateTime.now().weekday - 1;

  @override
  void initState() {
    super.initState();
    waitForMyTimes();
  }

  var colorList = [
    Colors.deepOrangeAccent,
    Colors.amber,
    Colors.lightGreen,
    Colors.tealAccent,
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.green,
    Colors.pinkAccent
  ];
  int count = 0;

  List week = ['월', '화', '수', '목', '금', '토', '일'];
  List weekE = [
    'MONDAY',
    'TUESDAY',
    'WEDNESDAY',
    'THURSDAY',
    'FRIDAY',
    'SATURDAY',
    'SUNDAY'
  ];
  double kFirstColumnHeight = 20;
  double kBoxSize = 52;

  List<TimeModel> myTimesMONDAY = [];
  List<TimeModel> myTimesTUESDAY = [];
  List<TimeModel> myTimesWEDNESDAY = [];
  List<TimeModel> myTimesTHURSDAY = [];
  List<TimeModel> myTimesFRIDAY = [];
  List<TimeModel> myTimesSATURDAY = [];
  List<TimeModel> myTimesSUNDAY = [];

  int minHour = 9;
  int maxHour = 16;
  int kColumnLength = 14;
  int basicsStartHour = 9;

  void setTime() {
    for (var lecture in myTimes) {
      List<String> startTimeParts = lecture.starttime.split(':');
      int startHours = int.parse(startTimeParts[0]);
      if (startHours < minHour) {
        minHour = startHours;
        setState(() {
          basicsStartHour = minHour;
        });
      }
      List<String> endTimeParts = lecture.endtime.split(':');
      int endHours = int.parse(endTimeParts[0]);
      int endMinutes = int.parse(endTimeParts[1]);
      double endTotalHour = endHours + endMinutes / 60;
      if (endTotalHour > maxHour) {
        maxHour = endTotalHour.ceil();
        setState(() {
          kColumnLength = (maxHour - basicsStartHour) * 2;
        });
      }
    }
  }

  Expanded buildTimeColumn() {
    return Expanded(
      child: Column(
        children: [
          SizedBox(
            height: kFirstColumnHeight,
          ),
          ...List.generate(
            kColumnLength,
                (index) {
              if (index % 2 == 0) {
                return const Divider(
                  color: Colors.grey,
                  height: 0,
                );
              }
              return SizedBox(
                height: kBoxSize,
                child: Center(child: Text('${index ~/ 2 + 9}')),
              );
            },
          ),
        ],
      ),
    );
  }

  List<TimeModel> aaaa(int todayWeek) {
    switch (todayWeek) {
      case 0:
        return myTimesMONDAY;
      case 1:
        return myTimesTUESDAY;
      case 2:
        return myTimesWEDNESDAY;
      case 3:
        return myTimesTHURSDAY;
      case 4:
        return myTimesFRIDAY;
      case 5:
        return myTimesSATURDAY;
      case 6:
        return myTimesSUNDAY;
      default:
        return [];
    }
  }

  double setTotalHour(var lecture, bool trigger) {
    if (trigger) {
      List<String> strTime = lecture.starttime.split(":");
      double hour = double.parse(strTime[0]);
      double minutesToHour = double.parse(strTime[1]) / 60;

      return hour + minutesToHour;
    } else {
      List<String> strTime = lecture.endtime.split(":");
      double hour = double.parse(strTime[0]);
      double minutesToHour = double.parse(strTime[1]) / 60;

      return hour + minutesToHour;
    }
  }

  Map<String, Color> timeColorMap = {};

  List<Widget> buildDayColumn(int index) {
    String currentDay = weekE[index];
    List<Widget> lecturesForTheDay = [];

    Color? timeColor;

    for (var lecture in myTimes) {
      double startTotalHour = setTotalHour(lecture, true);
      double endTotalHour = setTotalHour(lecture, false);
      double top = kFirstColumnHeight + kBoxSize * (startTotalHour - 9);
      double height = (endTotalHour - startTotalHour) * kBoxSize;

      if (timeColorMap.containsKey(lecture.lectureNum)) {
        timeColor = timeColorMap[lecture.lectureNum];
      } else {
        timeColor = (count == colorList.length
            ? colorList[count = 0]
            : colorList[count++]);
        timeColorMap[lecture.lectureNum] = timeColor;
      }

      if (lecture.week == currentDay) {
        switch (index) {
          case 0:
            myTimesMONDAY.add(lecture);
            myTimesMONDAY.sort((a, b) => a.starttime.compareTo(b.starttime));
            break;
          case 1:
            myTimesTUESDAY.add(lecture);
            myTimesTUESDAY.sort((a, b) => a.starttime.compareTo(b.starttime));
            break;
          case 2:
            myTimesWEDNESDAY.add(lecture);
            myTimesWEDNESDAY.sort((a, b) => a.starttime.compareTo(b.starttime));
            break;
          case 3:
            myTimesTHURSDAY.add(lecture);
            myTimesTHURSDAY.sort((a, b) => a.starttime.compareTo(b.starttime));
            break;
          case 4:
            myTimesFRIDAY.add(lecture);
            myTimesFRIDAY.sort((a, b) => a.starttime.compareTo(b.starttime));
            break;
        }
        lecturesForTheDay.add(
          Positioned(
            top: top,
            left: 1.2,
            child: Stack(children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Confirm Deletion'),
                        content:
                        Text('Are you sure you want to delete this item?'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('Delete'),
                            onPressed: () {
                              // 여기서 삭제 동작을 처리하세요.
                              setState(() async {
                                for (int i = 0; i < myTimes.length; i++) {
                                  if (myTimes[i].lectureNum ==
                                      lecture.lectureNum) {
                                    await mariaDB_server()
                                        .timetableDelete(myTimes[i].id!);
                                  }
                                }
                                waitForMyTimes();
                                Navigator.of(context).pop();
                              });
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  width:
                  (MediaQuery.of(context).size.width - 16) / 16 * 3 - 1.2,
                  height: height,
                  decoration: BoxDecoration(
                    color: timeColor,
                    borderRadius: kColumnLength / 2 + basicsStartHour ==
                        int.parse(lecture.endtime.split(":")[0])
                        ? const BorderRadius.only(
                      bottomRight: Radius.circular(12),
                    )
                        : const BorderRadius.all(Radius.circular(0)),
                  ),
                  child: Text(
                    "${lecture.lectureName}\n${lecture.classNum}",
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ]),
          ),
        );
      }
    }
    return [
      const VerticalDivider(
        color: Colors.grey,
        width: 0,
      ),
      Expanded(
        flex: 3,
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: kFirstColumnHeight,
                  child: Text(
                    '${week[index]}',
                  ),
                ),
                ...List.generate(
                  kColumnLength,
                      (index) {
                    if (index % 2 == 0) {
                      return const Divider(
                        color: Colors.grey,
                        height: 0,
                      );
                    }
                    return SizedBox(
                      height: kBoxSize,
                      child: Container(),
                    );
                  },
                ),
              ],
            ),
            ...lecturesForTheDay, // 현재 요일에 해당하는 모든 강의를 Stack에 추가
          ],
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    setTime();
    return Scaffold(
      body: DefaultTabController(
        length: 8,
        child: ExtendedNestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                surfaceTintColor: Colors.white,
                floating: false,
                pinned: true,
                title: Text("시간표"),
                actions: [
                  IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        Get.off(() => AddTimeTable());
                      }),
                ],
                shape: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: Text("오늘 할일"),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Container(
                      height: 150,
                      color: Colors.grey[600],
                      width: MediaQuery.of(context).size.width,
                      child: ListView.separated(
                        padding: const EdgeInsets.all(16),
                        scrollDirection: Axis.horizontal,
                        itemCount: aaaa(todayWeek).length,
                        itemBuilder: (context, index) {
                          var time = aaaa(todayWeek)[index];
                          return Container(
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                border:
                                Border.all(color: Colors.black, width: 1)),
                            child: Column(
                              children: [
                                Text(time.lectureName),
                                Text(time.lectureNum),
                                Text(time.starttime),
                                Text(time.endtime),
                                Text(time.building),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                      ),
                    ),
                  ],
                ),
              ),
              const SliverPersistentHeader(
                  pinned: true, delegate: CategoryBreadcrumbs()),
            ];
          },
          pinnedHeaderSliverHeightBuilder: () {
            return 48 +
                const SliverAppBar().toolbarHeight +
                MediaQuery.of(context).padding.top;
          },
          onlyOneScrollInBody: true,
          body: TabBarView(
            children: [
              CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      height:
                      kColumnLength / 2 * kBoxSize + kFirstColumnHeight + 2,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          buildTimeColumn(),
                          ...buildDayColumn(0),
                          ...buildDayColumn(1),
                          ...buildDayColumn(2),
                          ...buildDayColumn(3),
                          ...buildDayColumn(4),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              ListView.separated(
                padding: const EdgeInsets.all(16),
                scrollDirection: Axis.vertical,
                itemCount: myTimesMONDAY.length,
                itemBuilder: (context, index) {
                  var time = myTimesMONDAY[index];
                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1)),
                    child: Column(
                      children: [
                        Text(time.lectureName),
                        Text(time.lectureNum),
                        Text(time.starttime),
                        Text(time.endtime),
                        Text(time.building),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                const SizedBox(height: 10),
              ),
              ListView.separated(
                padding: const EdgeInsets.all(16),
                scrollDirection: Axis.vertical,
                itemCount: myTimesTUESDAY.length,
                itemBuilder: (context, index) {
                  var time = myTimesTUESDAY[index];
                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1)),
                    child: Column(
                      children: [
                        Text(time.lectureName),
                        Text(time.lectureNum),
                        Text(time.starttime),
                        Text(time.endtime),
                        Text(time.building),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                const SizedBox(height: 10),
              ),
              ListView.separated(
                padding: const EdgeInsets.all(16),
                scrollDirection: Axis.vertical,
                itemCount: myTimesWEDNESDAY.length,
                itemBuilder: (context, index) {
                  var time = myTimesWEDNESDAY[index];
                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1)),
                    child: Column(
                      children: [
                        Text(time.lectureName),
                        Text(time.lectureNum),
                        Text(time.starttime),
                        Text(time.endtime),
                        Text(time.building),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                const SizedBox(height: 10),
              ),
              ListView.separated(
                padding: const EdgeInsets.all(16),
                scrollDirection: Axis.vertical,
                itemCount: myTimesTHURSDAY.length,
                itemBuilder: (context, index) {
                  var time = myTimesTHURSDAY[index];
                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1)),
                    child: Column(
                      children: [
                        Text(time.lectureName),
                        Text(time.lectureNum),
                        Text(time.starttime),
                        Text(time.endtime),
                        Text(time.building),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                const SizedBox(height: 10),
              ),
              ListView.separated(
                padding: const EdgeInsets.all(16),
                scrollDirection: Axis.vertical,
                itemCount: myTimesFRIDAY.length,
                itemBuilder: (context, index) {
                  var time = myTimesFRIDAY[index];
                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1)),
                    child: Column(
                      children: [
                        Text(time.lectureName),
                        Text(time.lectureNum),
                        Text(time.starttime),
                        Text(time.endtime),
                        Text(time.building),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                const SizedBox(height: 10),
              ),
              ListView.separated(
                padding: const EdgeInsets.all(16),
                scrollDirection: Axis.vertical,
                itemCount: myTimesSATURDAY.length,
                itemBuilder: (context, index) {
                  var time = myTimesSATURDAY[index];
                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1)),
                    child: Column(
                      children: [
                        Text(time.lectureName),
                        Text(time.lectureNum),
                        Text(time.starttime),
                        Text(time.endtime),
                        Text(time.building),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                const SizedBox(height: 10),
              ),
              ListView.separated(
                padding: const EdgeInsets.all(16),
                scrollDirection: Axis.vertical,
                itemCount: myTimesSUNDAY.length,
                itemBuilder: (context, index) {
                  var time = myTimesSUNDAY[index];
                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1)),
                    child: Column(
                      children: [
                        Text(time.lectureName),
                        Text(time.lectureNum),
                        Text(time.starttime),
                        Text(time.endtime),
                        Text(time.building),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                const SizedBox(height: 10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryBreadcrumbs extends SliverPersistentHeaderDelegate {
  const CategoryBreadcrumbs();

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return const TabBar(
      tabs: [
        Tab(
          child: Text(
            "전체",
          ),
        ),
        Tab(
          child: Text(
            "월",
          ),
        ),
        Tab(
          child: Text(
            "화",
          ),
        ),
        Tab(
          child: Text(
            "수",
          ),
        ),
        Tab(
          child: Text(
            "목",
          ),
        ),
        Tab(
          child: Text(
            "금",
          ),
        ),
        Tab(
          child: Text(
            "토",
          ),
        ),
        Tab(
          child: Text(
            "일",
          ),
        ),
      ],
      indicatorWeight: 2,
      unselectedLabelColor: Colors.grey,
      labelColor: Colors.black,
      indicatorColor: Colors.black,
      indicatorSize: TabBarIndicatorSize.label,
    );
  }

  @override
  double get maxExtent => 48;

  @override
  double get minExtent => 48;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
