import 'package:project_2/bus_/bus_station.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../Bus_dio.dart';
import 'bus_number_data_body.dart';
import 'bus_number_data_head.dart';
import 'package:project_2/bus_/bus_data.dart';

class Bus_number_data_main extends StatefulWidget {
  const Bus_number_data_main({super.key});

  @override
  State<Bus_number_data_main> createState() => _Bus_number_data_mainState();
}

class _Bus_number_data_mainState extends State<Bus_number_data_main> {
  Bus_data bus_data = Bus_data();
  Bus_dio dio = Bus_dio();
  List<Map<String, int>>? bus_number_data;
  Map<String, dynamic>? result;

  Map<String, int> data = Get.arguments;

  Future<void> init_page() async {
    print("object");
    bus_number_data = bus_data.bus_number_data(data.keys.first);
    result = await dio.Bus_get(data.keys.first);
    print("object");
  }

  void reset_page(String bus_number) {
    setState(() {
      dio.Bus_get(bus_number);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: init_page(), builder: (context,snapshot){    ///이거 꼭 공부하셈
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
          body: Column(
            children: [
              Expanded(
                flex: 11,
                child: Bus_number_data_head(
                  title: data.keys.first,
                  bus_station_number: data[data.keys.first],
                  reset_page: reset_page,
                ),
              ),
              Expanded(
                flex: 30,
                child: Bus_number_data_body(
                  bus_number: bus_number_data,
                  result: result,
                ),
              ),
            ],
          ),
        );
      }
    },
    );
  }
}
