import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:project_2/Building_map/Building_data.dart';
import 'package:photo_view/photo_view.dart';
import 'package:project_2/Server_conn/mariaDB_server.dart';
import 'package:project_2/Building_map/img_file.dart';
import 'package:project_2/img_page.dart';

class swiper_test2 extends StatefulWidget {
  const swiper_test2({super.key});

  @override
  State<swiper_test2> createState() => _swiper_test2State();
}

class _swiper_test2State extends State<swiper_test2> {
  int _currentIndex = 0;
  int _selectedFloor = 1;
  final CarouselController _carouselController = CarouselController();
  final img_file building_img = img_file();
  List<dynamic> _psrl = <dynamic>[];
  ScrollController _scrollController = ScrollController();
  building_data tes = building_data();
  List<int> floor = [0, 0, 0, 0, 0, 0];
  int number = 0;

  void initState() {
    int count = 0;

    super.initState();
    mariaDB_server().find_room(Get.arguments).then(
      (value) {
        setState(
          () {
            if (Get.arguments == "공대1호관" ||
                Get.arguments == "공대2호관" ||
                Get.arguments == "공대3호관" ||
                Get.arguments == "공대4호관") {
              number = 1;
            }
            _psrl = value;
            print(value);
            print(value[0]["classNum"][number]);
            for (int i = 0; i < value.length; i++) {
              if (int.parse(value[i]["classNum"][number]) != 0 &&
                  floor[int.parse(value[i]["classNum"][number])] == 0) {
                floor[int.parse(value[i]["classNum"][number])] = count;
              }
              count++;
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> test_st = tes.make_building(Get.arguments);
    int count = 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(Get.arguments),
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              CarouselSlider(
                carouselController: _carouselController,
                options: CarouselOptions(
                  height: 300.0,
                  onPageChanged: (index, reason) {
                    setState(
                      () {
                        _currentIndex = index;
                      },
                    );
                  },
                ),
                items: test_st.map(
                  (i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 12.0),
                              decoration: BoxDecoration(color: Colors.white),
                              child: Center(
                                child: Image.asset(img_building(
                                    Get.arguments, test_st.indexOf(i))),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                List<String> img = [
                                  img_building(
                                      Get.arguments, test_st.indexOf(i))
                                ];
                                Get.to(Img_page(), arguments: img);
                              },
                              child: Text("확대"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ).toList(),
              ),
              SizedBox(
                height: 350,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (int i = test_st.length; i >= 1; i--)
                            Container(
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _selectedFloor = i;
                                  });
                                  _carouselController.animateToPage(i - 1);
                                  _scrollToPosition(floor[i - 1]);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _selectedFloor == i
                                      ? Colors.green
                                      : Colors.blue,
                                ),
                                child: Text(
                                  '${test_st[i - 1]}',
                                  style: TextStyle(fontSize: 11),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    null_room(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String img_building(String building_name, int count) {
    Map<String, List<String>> test = building_img.get_img_building();
    bool check = test.containsKey(building_name);
    if (check) {
      String? test_data = test["$building_name"]?[count];
      if (test_data != null) {
        return test_data;
      }
    } else {
      return "images/kmu_1.png";
    }
    return "images/kmu_1.png";
  }

  Widget null_room() {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: _psrl.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              String floor = _psrl[index]["classNum"];
              print(floor[number]);
              int floor_n = int.parse(floor[number]);
              _carouselController.animateToPage(floor_n);
              _selectedFloor = floor_n + 1;
            },
            child: Card(
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(width: 1, color: Colors.blue),
              ),
              elevation: 0.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          _psrl[index]["classNum"],
                          style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          "다음 수업시간 :${_psrl[index]["nextStartTime"] != null ? _psrl[index]["nextStartTime"] : "수업없음"}",
                          style: const TextStyle(
                            fontSize: 15,
                            //fontWeight: FontWeight.bold, 글자 굵게
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _scrollToPosition(int index) {
    // ScrollController를 사용하여 특정 위치로 스크롤
    _scrollController.animateTo(
      index * 54, // 각 항목의 높이에 따라 조절
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
