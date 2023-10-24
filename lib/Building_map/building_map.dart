import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class swiper_test extends StatefulWidget {
  const swiper_test({super.key});

  @override
  State<swiper_test> createState() => _swiper_testState();
}

class _swiper_testState extends State<swiper_test> {
  int _currentIndex = 0;
  int _selectedFloor = 1;
  CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test_carousel"),
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
                          color: _selectedFloor == i ? Colors.blue : Colors.amber,
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
                      child: Text('이미지 $i',style: TextStyle(fontSize: 11),),
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
