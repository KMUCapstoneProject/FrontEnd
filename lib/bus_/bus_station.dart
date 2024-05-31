import 'package:project_2/bus_/bus_data/bus_number_data_main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class Bus_station extends StatelessWidget {
  final int m_count;
  final List<Map<String, int>> m_test;
  final List<Map<String, dynamic>> m_post;

  Bus_station(
      {required this.m_post, required this.m_count, required this.m_test});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: GestureDetector(
        onTap: () async {
          await Get.to(
            Bus_number_data_main(),
            arguments: m_test[m_count],
          );
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black87, width: 0.2),
              borderRadius: BorderRadius.circular(5)),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 20,
                child: bus_station_content(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bus_station_content() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                  child: Text(
                    m_post[m_count]["bus_station"].toString(),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Icon(Icons.bus_alert_sharp),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      m_post[m_count]["bus_number"].toString(),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
