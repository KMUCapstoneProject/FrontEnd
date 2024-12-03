import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/google_map_page/google_map.dart';

class start_page extends StatefulWidget {
  const start_page({super.key});

  @override
  State<start_page> createState() => _start_pageState();
}

class _start_pageState extends State<start_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                "images/그림1.png",
                width: 450,
                height: 360,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 50,
              child: Text(
                "계명여지도",
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.blue,
                    fontFamily: 'notosanscjkkr'),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Center(
              child: FloatingActionButton(
                onPressed: () {
                  Get.to(kmu_map());
                },
                child: Icon(
                  Icons.arrow_forward,
                  size: 35,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
