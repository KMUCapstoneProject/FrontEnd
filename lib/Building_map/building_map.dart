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

  var titlelist = [
    "test",
    "test1",
    "test2",
    "test3",
    "test4",
    "test5",
    "test6",
    "test7",
    "test8",
    "test9",
    "test10",
  ];

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
              height: 350,
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
                  null_room(),
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


  Widget null_room() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemCount: titlelist.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){},
            child: Card(
              child: Row(
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset("images/kmu_1.png"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          titlelist[index],
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
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
}
