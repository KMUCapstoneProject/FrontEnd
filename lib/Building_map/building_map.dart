import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:project_2/Building_map/Building_data.dart';
import 'package:photo_view/photo_view.dart';
import 'package:project_2/img_file.dart';

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

  building_data tes = building_data();

  @override
  Widget build(BuildContext context) {
    List<String> test_st = tes.make_building(Get.arguments);
    int count =0;

    return Scaffold(
      appBar: AppBar(
        title: Text(Get.arguments),
      ),
      body: SingleChildScrollView(
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
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          color: _currentIndex == test_st.indexOf(i)
                              ? Colors.blue
                              : Colors.amber,
                        ),
                        child: Center(
                          child: Image.asset(img_building(Get.arguments, test_st.indexOf(i))),
                        ),
                      );
                    },
                  );
                },
              ).toList(),
            ),
            SizedBox(
              height: 300,
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int i = test_st.length; i >= 1; i--)
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _selectedFloor = i;
                              });
                              _carouselController.animateToPage(i - 1);
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
                  Text("data"),
                  Text("data"),
                  Text("data"),
                  Text("data"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  String img_building(String building_name,int count)
  {
    Map<String,List<String>> test = building_img.get_img_building();
    bool check = test.containsKey(building_name);
    if(check)
      {
        String? test_data = test["$building_name"]?[count];
        if(test_data != null)
          {
            return test_data;
          }
      }
    else
      {
        return "images/kmu_1.png";
      }
    return "images/kmu_1.png";
  }

}


/*
class swiper_test extends StatefulWidget {
  const swiper_test({super.key});

  @override
  State<swiper_test> createState() => _swiper_testState();
}

class _swiper_testState extends State<swiper_test> {
  int _currentIndex = 0;
  int _selectedFloor = 1;
  CarouselController _carouselController = CarouselController();

  List<int> test_ls = [1, 2, 3, 4, 5];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Get.arguments),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              carouselController: _carouselController,
              options: CarouselOptions(
                height: 400.0,
                onPageChanged: (index, reason) {
                  setState(
                    () {
                      _currentIndex = index;
                    },
                  );
                },
              ),
              items: [1, 2, 3, 4, 5].map(
                (i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          color:
                              _selectedFloor == i ? Colors.blue : Colors.amber,
                        ),
                        child: Center(
                          child: Text(
                            'Image $i',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      );
                    },
                  );
                },
              ).toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 1; i <= 5; i++)
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedFloor = i;
                        });
                        _carouselController.animateToPage(i - 1);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            _selectedFloor == i ? Colors.green : Colors.blue,
                      ),
                      child: Text(
                        '이미지 $i',
                        style: TextStyle(fontSize: 11),
                      ),
                    ),
                  ),
              ],
            ),
            Text('현재 이미지: ${_currentIndex + 1}'),
          ],
        ),
      ),
    );
  }
}
*/