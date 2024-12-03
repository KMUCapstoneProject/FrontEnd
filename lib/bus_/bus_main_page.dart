import 'package:project_2/bus_/Bus_dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'bus_station.dart';
import 'package:dio/dio.dart';

class Bus_main_page extends StatefulWidget {
  const Bus_main_page({super.key});

  @override
  State<Bus_main_page> createState() => _bus_main_pageState();
}

class _bus_main_pageState extends State<Bus_main_page> {
  int num = 0;
  Bus_dio get = Bus_dio();

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> _posts = [
      { "bus_station" : "계명대학교동산병원앞",
        "bus_number" : 21199},
      { "bus_station" : "계명대학교동산병원건너",
        "bus_number" : 21194},
      { "bus_station" : "계명대학교정문앞",
        "bus_number" : 21195},
      { "bus_station" : "계명대학교정문건너",
        "bus_number" : 21198},
      { "bus_station" : "계명대역(1번출구)",
        "bus_number" : 21196},
      { "bus_station" : "계명대역(2번출구)",
        "bus_number" : 21197},
      { "bus_station" : "계명대학교동문앞",
        "bus_number" : 05012},
      { "bus_station" : "계명대학교동문건너2",
        "bus_number" : 21519},
      { "bus_station" : "계명대학교동문건너1",
        "bus_number" : 00898},
      { "bus_station" : "계명문화대학앞",
        "bus_number" : 21132},
      { "bus_station" : "계명문화대학건너",
        "bus_number" : 05011},
    ];

    List<Map<String, int>> test_box = [
      {"계명대학교동산병원앞": 21199},
      {"계명대학교동산병원건너": 21194},
      {"계명대학교정문앞": 21195},
      {"계명대학교정문건너": 21198},
      {"계명대역(1번출구)": 21196},
      {"계명대역(2번출구)": 21197},
      {"계명대학교동문앞": 05012},
      {"계명대학교동문건너2": 21519},
      {"계명대학교동문건너1": 00898},
      {"계명문화대학앞": 21132},
      {"계명문화대학건너": 05011},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "버스정류장",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: GridView.count(
        childAspectRatio: 1.7,
        crossAxisCount: 2, // 한 행에 표시할 아이템의 수 (2개의 열)
        children: List.generate(_posts.length, (index) {
          return Bus_station(
            m_post: _posts,
            m_count: index,
            m_test: test_box,
          );
        }),
      ),
    );
  }
}
