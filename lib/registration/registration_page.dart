import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:get/get.dart';
import '../Server_conn/mariaDB_server.dart';

class registration_page extends StatefulWidget {
  const registration_page({super.key});

  @override
  State<registration_page> createState() => _registration_pageState();
}

class _registration_pageState extends State<registration_page> {
  List<XFile> imageFiles = [];

  //제목 컨트롤러
  TextEditingController title_ctr = TextEditingController();

  //내용 컨트롤러
  TextEditingController content_ctr = TextEditingController();

  //위치 컨트롤러
  TextEditingController locaton_ctr = TextEditingController();

  // 프로그램 기간
  String startDate = "시작 날짜";
  String endDate = "마감 날짜";
  String startTime = "시작 시간";
  String endTime = "마감 시간";
// 이미지를 선택해서 리스트에 저장하는 함수
  Future<void> _pickImage() async {
    final List<XFile> images = await ImagePicker().pickMultiImage();
    setState(() {
      imageFiles += images;
    });
  }

  // 이미지를 삭제하는 함수
  void _removeImage(int index) {
    setState(() {
      imageFiles.removeAt(index);
    });
  }

  // 달력을 보여주고 선택한 날짜를 startData에 저장하는 함수
  setStartData() async {
    DateTime? selectedDate;
    selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2027),
    );
    setState(() {
      if (selectedDate != null) {
        startDate = selectedDate.toString().split(" ")[0];
      }
    });
  }

  // 달력을 보여주고 선택한 날짜를 endData에 저장하는 함수

  setEndData() async {
    DateTime? selectedDate;
    if (startDate != '시작 날짜') {
      List<String> date = startDate.split('-');
      int year = int.parse(date[0]);
      int month = int.parse(date[1]);
      int day = int.parse(date[2]);
      selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime(year, month, day),
        firstDate: DateTime(year, month, day),
        lastDate: DateTime(2027),
      );
    } else {
      selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime(2027),
      );
    }
    setState(() {
      if (selectedDate != null) {
        endDate = selectedDate.toString().split(" ")[0];
      }
    });
  }

  // 시작시간 설정
  setStartTime() async {
    Future<TimeOfDay?> selectedTime;
    selectedTime = showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    selectedTime.then((value) {
      if (value != null) {
        setState(() {
          if (value.minute < 10) {
            startTime = "${value.hour}:0${value.minute}";
          } else {
            startTime = "${value.hour}:${value.minute}";
          }
        });
      }
    });
  }

  // 마감시간 설정
  setEndTime() async {
    Future<TimeOfDay?> selectedTime;
    selectedTime = showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    selectedTime.then((value) {
      if (value != null) {
        setState(() {
          if (value.minute < 10) {
            endTime = "${value.hour}:0${value.minute}";
          } else {
            endTime = "${value.hour}:${value.minute}";
          }
        });
      }
    });
  }
  // 앱바에 완료버튼을 누르면 이제 내용을 서버에 전송
  upload() async {
    String start = "$startDate $startTime:00";
    String end = "$endDate $endTime:00";
    await mariaDB_server().event_registration_input(2, title_ctr.text, content_ctr.text, start, end, 0.0, 0.0, locaton_ctr.text,imageFiles);
    Get.back();
  }

  // 앱바에 아이콘을 누르면 비교과프로그램 등록 이전 화면으로 이동
  backScrean() async {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('비교과 프로그램 등록'),
        // 앱바의 왼쪽
        leading: IconButton(
          onPressed: backScrean,
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18))),
              ),
              onPressed: () {
                upload();
                },
              child: const Text('완료'),
            ),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 5,
                      child: Container(
                        margin: const EdgeInsets.only(left: 5, right: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          onPressed: setStartData,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 20),
                                    child: const Icon(
                                      Icons.date_range_outlined,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    startDate,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Container(
                        margin: const EdgeInsets.only(left: 5, right: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          onPressed: setStartTime,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(right: 20),
                                    child: const Icon(
                                      Icons.access_time_sharp,
                                      color: Colors.black,
                                    )),
                                Text(
                                  startTime,
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 5,
                      child: Container(
                        margin: const EdgeInsets.only(left: 5, right: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          onPressed: setEndData,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 20),
                                    child: const Icon(
                                      Icons.date_range_outlined,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    endDate,
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Container(
                        margin: const EdgeInsets.only(left: 5, right: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          onPressed: setEndTime,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(right: 20),
                                    child: const Icon(
                                      Icons.access_time_sharp,
                                      color: Colors.black,
                                    )),
                                Text(
                                  endTime,
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                width: MediaQuery.of(context).size.width * 0.9,
                height: 35,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: Container(
                  padding: const EdgeInsets.only(bottom: 2, left: 2, right: 2),
                  child: TextField(
                    controller: locaton_ctr,
                    decoration: const InputDecoration(
                      hintText: '정확한 위치를 입력하시오',
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 10, left: 10),
                height: 180,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: imageFiles.length + 1,
                  itemBuilder: (context, index) {
                    // 마지막 아이템에 ElevatedButton 추가
                    if (index == imageFiles.length) {
                      // GestureDetector 화면 터치 감지
                      return GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          width: 180,
                          height: 180,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(20)),
                          child: const Center(
                            child: Icon(Icons.add_photo_alternate_rounded,
                                size: 50), // 아이콘 추가
                          ),
                        ),
                      );
                    } else {
                      // 이미지위에 버튼을 생성하기위해 Stack 사용
                      return Stack(
                        children: [
                          // 이미지 상자 테두리에 굴곡을 만들기 위해 ClipRRect사용
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.file(
                                File(imageFiles[index].path),
                                width: 180,
                                height: 180,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          // 이미지 좌표 위에 버븐 생성
                          Positioned(
                            top: 0,
                            right: 0,
                            child: IconButton(
                              onPressed: () {
                                _removeImage(index);
                              },
                              icon: const Icon(
                                Icons.cancel,
                                size: 40,
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                  // 리스트 item 간격 설정
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 10,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: TextField(
                  controller: title_ctr,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                    hintText: '제목을 입력하세요(필수)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: TextField(
                  controller: content_ctr,
                  maxLines: 20,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    hintText: '본문을 입력하세요',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
