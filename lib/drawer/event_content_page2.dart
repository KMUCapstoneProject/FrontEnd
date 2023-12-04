import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/Server_conn/mariaDB_server.dart';
import 'package:project_2/drawer/event_list.dart';

class event_content_page extends StatelessWidget {
  const event_content_page({super.key});

  /*

          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.8,
   */
  @override
  Widget build(BuildContext context) {

    Map<String,dynamic> _psrl_data = Get.arguments;


    return Scaffold(
      appBar: AppBar(
        title: Text(_psrl_data["postId"].toString()),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: 286,
          height: 475,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: Color(0xFFA79880),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 24,
                top: 20,
                child: SizedBox(
                  width: 228,
                  height: 45,
                  child: Text(
                    '제목:운동',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontFamily: 'Epilogue',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 23,
                top: 82,
                child: SizedBox(
                  width: 241,
                  height: 75,
                  child: Text(
                    '시간:\n2023-12-03 19:34~\n2023-12-05 19:34',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'Epilogue',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 18,
                top: 221,
                child: SizedBox(
                  width: 246,
                  height: 59,
                  child: Text(
                    '장소 : 운동회',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Epilogue',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 18,
                top: 293,
                child: SizedBox(
                  width: 256,
                  height: 99,
                  child: Text(
                    '내용: 화이팅',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Epilogue',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 93,
                top: 405,
                child: Container(
                  width: 100,
                  height: 62,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 25,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: 100,
                                height: 25,
                                decoration: ShapeDecoration(
                                  color: Color(0xFFC8C68D),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 9,
                              top: 6,
                              child: SizedBox(
                                width: 85,
                                height: 14,
                                child: Text(
                                  '수락',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: 100,
                        height: 25,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: 100,
                                height: 25,
                                decoration: ShapeDecoration(
                                  color: Color(0xFFC8C68D),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 9,
                              top: 6,
                              child: SizedBox(
                                width: 85,
                                height: 14,
                                child: Text(
                                  '거절',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
