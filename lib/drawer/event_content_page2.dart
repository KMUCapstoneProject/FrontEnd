import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/Server_conn/mariaDB_server.dart';
import 'package:project_2/drawer/event_list.dart';
import 'package:project_2/img_page.dart';

class event_content_page2 extends StatelessWidget {
  const event_content_page2({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> _psrl_data = Get.arguments;
    String _title = _psrl_data["title"];
    List<String> _startTime = _psrl_data["startTime"].toString().split("T");
    List<String> _endTime = _psrl_data["deadline"].toString().split("T");
    String _place = _psrl_data["details"];
    String _content = _psrl_data["content"];

    return Scaffold(
      appBar: AppBar(
        title: Text("test"),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          height: MediaQuery.of(context).size.height * 0.75,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: Color(0xFFA79880),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.to(Img_page(),arguments: _psrl_data["imgUrl"]);
                  },
                  child: Text("첨부\n이미지"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFC8C68D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 80,
                  child: Text(
                    '제목: $_title',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontFamily: 'Epilogue',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 85,
                  child: Text(
                    '시간:\n ${_startTime[0]} ${_startTime[1]} ~ \n${_endTime[0]} ${_endTime[1]}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Epilogue',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Text(
                    '장소 : $_place',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Epilogue',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 150,
                  child: Text(
                    '내용: $_content',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Epilogue',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          await mariaDB_server()
                              .event_list_upgrade(_psrl_data["postId"]);
                          Get.off(event_list());
                        },
                        child: Text("수락"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFC8C68D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await mariaDB_server()
                              .event_list_delete(_psrl_data["postId"]);
                          Get.off(event_list());
                        },
                        child: Text("거절"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFC8C68D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      )
                    ],
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
