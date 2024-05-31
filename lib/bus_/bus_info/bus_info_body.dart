import 'package:project_2/bus_/bus_info/bus_info_head.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'bus_info_body_object.dart';

class Bus_info_body extends StatefulWidget {
  final List<List<String>>? data;
  final int type;
  final List<Map<String, String>>? bus_list;

  const Bus_info_body(
      {super.key,
      required this.data,
      required this.type,
      required this.bus_list});


  @override
  State<Bus_info_body> createState() => _Bus_info_bodyState();
}

class _Bus_info_bodyState extends State<Bus_info_body> {
  @override
  Widget build(BuildContext context) {
    Bus_info_body_object_class aaa = Bus_info_body_object_class();

    List<String>? bus_station_name = widget.data?[widget.type];

    print("print : ${bus_station_name}");

    return Container(
      padding: EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemCount: bus_station_name?.length,
        itemBuilder: (context, index) {
          bool check = false;

          for (Map<String, String> data in widget.bus_list!) {
            if (bus_station_name?[index] == data["nodenm"]) {
              check = true;
            }
          }

          if (index == 0) {
            return Container(
              height: 50,
              child: aaa.bus_station_start(bus_station_name![index], check),
            );
          } else if (index == bus_station_name!.length - 1) {
            return Container(
              height: 50,
              child: aaa.bus_station_end(bus_station_name[index], check),
            );
          } else {
            return Container(
              height: 50,
              child: aaa.bus_station_mid(bus_station_name[index], check),
            );
          }
        },
      ),
    );
  }
}
