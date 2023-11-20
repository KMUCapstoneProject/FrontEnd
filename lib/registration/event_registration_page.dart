import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:project_2/registration/search_google.dart';

class event_registration extends StatefulWidget {
  const event_registration({super.key});

  @override
  State<event_registration> createState() => _event_registrationState();
}

class _event_registrationState extends State<event_registration> {
  List<XFile> imageFiles = [];
  String Lat = "                 ";
  String Lng = "                 ";

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
    selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2027),
    );
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
          startTime = "${value.hour}:${value.minute}";
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
          endTime = "${value.hour}:${value.minute}";
        });
      }
    });
  }

  // 앱바에 완료버튼을 누르면 이제 내용을 서버에 전송
  upload() async {}

  // 앱바에 아이콘을 누르면 비교과프로그램 등록 이전 화면으로 이동
  backScrean() async {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("행사신청"),
      ),
      body: SingleChildScrollView(
        //스크롤 할수있게하는 위젯
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Flexible(
                    child: OutlinedButton(
                      onPressed: setStartData,
                      child: Icon(Icons.date_range_outlined),
                      style: ElevatedButton.styleFrom(
                          side: BorderSide(color: Colors.black, width: 1.3),
                          fixedSize: Size(100, 60),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          )),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                      ),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          startDate,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    '~',
                    style: TextStyle(fontSize: 23),
                  ),
                  Flexible(
                    child: OutlinedButton(
                      onPressed: setEndData,
                      child: Icon(Icons.date_range_outlined),
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(color: Colors.black, width: 1.3),
                        fixedSize: Size(100, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                      ),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          endDate,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Flexible(
                    child: OutlinedButton(
                      onPressed: setStartTime,
                      child: Icon(Icons.access_time_sharp),
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(color: Colors.black, width: 1.3),
                        fixedSize: Size(100, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                      ),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          startTime,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    '~',
                    style: TextStyle(fontSize: 23),
                  ),
                  Flexible(
                    child: OutlinedButton(
                      onPressed: setEndTime,
                      child: Icon(Icons.access_time_sharp),
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(color: Colors.black, width: 1.3),
                        fixedSize: Size(100, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                      ),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          endTime,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              height: 60,
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      LatLng data = await Get.to(search_google());
                      setState(() {
                        Lat = data.latitude.toStringAsFixed(5);
                        Lng = data.longitude.toStringAsFixed(5);
                      });
                    },
                    child: Text("위치"),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 250,
                    height: 35,
                    child: Center(
                      child: Text("Lat: $Lat   lng: $Lng   ",style: TextStyle(fontSize: 16),),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 200,
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
                        width: 200,
                        height: 200,
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
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(
                            File(imageFiles[index].path),
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
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
            const SizedBox(
              height: 15,
            ),
            const TextField(
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(hintText: '제목을 입력하세요(필수)'),
            ),
            const TextField(
              maxLines: 1000,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(hintText: '본문을 입력하세요'),
            ),
          ],
        ),
      ),
    );
  }
}
