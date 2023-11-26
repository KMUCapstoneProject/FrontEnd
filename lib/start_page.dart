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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset("images/kmu_rm_b2.png",
                width: 350, height: 250, fit: BoxFit.fill),
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
          Center(
            child: ElevatedButton(
              onPressed: () {
                Get.off(kmu_map());
              },
              child: Text("시작"),
            ),
          )
        ],
      ),
    );
  }
}
