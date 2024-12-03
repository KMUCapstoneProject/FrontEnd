import 'package:project_2/bus_/Bus_dio.dart';
import 'package:project_2/bus_/bus_data.dart';
import 'package:project_2/bus_/bus_data2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'bus_info_body.dart';
import 'bus_info_body_object.dart';
import 'bus_info_head.dart';

class Bus_info_main extends StatefulWidget {
  const Bus_info_main({super.key});

  @override
  State<Bus_info_main> createState() => _Bus_info_mainState();
}

class _Bus_info_mainState extends State<Bus_info_main> {
  Bus_info_body_object_class aaa = Bus_info_body_object_class();
  Bus_data2 bus_stations = Bus_data2();
  Bus_data bus_station = Bus_data();
  late String bus_number = Get.arguments[0];
  List<List<String>>? bus_station_list;
  List<Map<String, String>>? bus_point;

  Future<List<Map<String, String>>?> reset_page(String bus_name) async {
    print("error 123");

    String? bus_number = bus_station.get_bus_number(bus_name);

    print(bus_number);
    Bus_dio dio = Bus_dio();
    bus_point = await dio.Bus_now_traget(bus_number!);

    print("check: ${bus_point}");

    if(bus_point==null)
      {
        bus_point = [];
      }

    bus_station_list = bus_stations.get_station(this.bus_number);

    return bus_point;
  }

  @override
  Widget build(BuildContext context) {
    late int box = Get.arguments[1];

    print("number data: ${box}");


    return FutureBuilder(
        future: reset_page(bus_number),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text('Error: ${snapshot.error}'),
              ),
            );
          } else {
            return Scaffold(
              backgroundColor: Colors.grey[200],
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Text("노선 상세정보"),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: Bus_info_head(
                      reset: reset_page,
                      bus_num: bus_number,
                      station_start: bus_station_list![0][0],
                      station_end: bus_station_list![0]
                          [bus_station_list![0].length - 1],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    flex: 6,
                    child: Bus_info_body(
                      data: bus_station_list,
                      type: box,
                      bus_list: bus_point,
                    ),
                  ),
                ],
              ),
            );
          }
        });

/*
    return Scaffold(
      backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("노선 상세정보"),
        ),
        body: Column(
          children: [
            Expanded(
              child: Bus_info_head(
                  reset: reset,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 6,
              child: Bus_info_body(),
            ),
          ],
        ));
    */
  }

  reset(int number) {
    setState(() {
      aaa.now_bus_target(number);
    });
  }
}
