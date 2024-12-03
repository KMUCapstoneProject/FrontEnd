import 'package:flutter/material.dart';
import '../Server_conn/mariaDB_server.dart';
import 'package:project_2/time/timeTable.dart';
import 'package:project_2/time/time_model.dart';
import 'package:get/get.dart';

class AddTimeTable extends StatefulWidget {
  const AddTimeTable({super.key});

  @override
  State<AddTimeTable> createState() => _AddTimeTableState();
}

class _AddTimeTableState extends State<AddTimeTable> {
  List<TimeModel> myTimes = [];

  void waitForMyTimes() async {
    myTimes = await mariaDB_server().loabbyUser();
    setState(() {});
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

  String selectNum = "";

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
        lecturesForTheDay.add(
          Positioned(
            top: top,
            left: 1.2,
            child: Stack(children: [
              Container(
                width: (MediaQuery.of(context).size.width - 16) / 16 * 3 - 1.2,
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

  String? _selectedOption = '과목명';
  int a = 1;

  @override
  void initState() {
    super.initState();
    appBarHeight = AppBar().preferredSize.height; // initState에서 앱바의 높이 계산
    waitForMyTimes();
  }

  List<TimeModel> times = [];
  List<List<TimeModel>> tt = [];

  void b() {
    tt = [];
    String zz = "";
    List<TimeModel> vv = [];
    for (int i = 0; i < times.length; i++) {
      if (zz == "") {
        zz = times[i].lectureNum;
        vv.add(times[i]);
        continue;
      } else if (zz == times[i].lectureNum) {
        vv.add(times[i]);
        continue;
      } else {
        tt.add(List.from(vv)); // 새로운 리스트로 추가
        vv.clear();
        zz = times[i].lectureNum;
        vv.add(times[i]);
      }
    }
    if (vv.isNotEmpty) {
      tt.add(List.from(vv)); // 남아있는 리스트 추가
    }
    setState(() {
      // 상태 업데이트
    });
  }

  void _handleRadioValueChange(String? value) {
    setState(() {
      _selectedOption = value;
      if (_selectedOption == '과목명') {
        a = 1;
      } else {
        a = 2;
      }
    });
  }

  late double appBarHeight; // 앱바의 높이를 저장할 변수 선언
  final _contentEditController = TextEditingController();
  bool ot = false;

  @override
  Widget build(BuildContext context) {
    setTime();
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        Get.off(() => TimeTable());
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Get.off(() => TimeTable());
              }),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                flex: 1,
                child: TextField(
                  controller: _contentEditController,
                  onEditingComplete: () {
                    setState(() async {
                      times = await mariaDB_server()
                          .searchSchool(_contentEditController.text, a);
                      b();
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    hintText: '검색 키워드를 입력해주세요',
                  ),
                ),
              ),
            ],
          ),
          bottom: PreferredSize(
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 50),
                    child: Row(
                      children: [
                        Radio<String>(
                          value: '과목명',
                          groupValue: _selectedOption,
                          onChanged: _handleRadioValueChange,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {
                            _handleRadioValueChange('과목명');
                          },
                          child: Text('과목명'),
                        ),
                        Radio<String>(
                          value: '강좌번호',
                          groupValue: _selectedOption,
                          onChanged: _handleRadioValueChange,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {
                            _handleRadioValueChange('강좌번호');
                          },
                          child: Text('강좌번호'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            preferredSize: Size(0, 40),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height -
                appBarHeight -
                40 -
                MediaQuery.of(context).padding.top,
            child: Column(
              children: [
                Container(
                  height: (MediaQuery.of(context).size.height -
                      appBarHeight -
                      40 -
                      MediaQuery.of(context).padding.top) *
                      0.4,
                  child: SingleChildScrollView(
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
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  width: double.maxFinite,
                  height: (MediaQuery.of(context).size.height -
                      appBarHeight -
                      40 -
                      MediaQuery.of(context).padding.top) *
                      0.6,
                  child: ListView.separated(
                    padding: EdgeInsets.all(16),
                    scrollDirection: Axis.vertical,
                    itemCount: tt.length,
                    itemBuilder: (context, index) {
                      var time = tt[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (selectNum == time[0].lectureNum) {
                              selectNum = "";
                            } else {
                              selectNum = time[0].lectureNum;
                            }
                          });
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(time[0].lectureNum),
                            Text(time[0].lectureName),
                            for (var n in time)
                              Row(
                                children: [
                                  Text(n.week),
                                  Text(n.starttime),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(n.endtime),
                                ],
                              ),
                            if (selectNum == time[0].lectureNum)
                              TextButton(
                                onPressed: () {
                                  setState(() async {
                                    for (int i = 0; i < time.length; i++) {
                                      await mariaDB_server()
                                          .addSchool(time[i].timetableId!);
                                    }
                                    print("ㅜㅜㅜㅜㅜㅜ");
                                    waitForMyTimes();
                                  });
                                },
                                child: Text("추가"),
                              ),

                            SizedBox(height: 10), // 각 항목 사이의 간격 조정을 위해 추가
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 10),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
