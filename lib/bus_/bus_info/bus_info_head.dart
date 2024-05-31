import 'package:project_2/bus_/bus_info/bus_info_body_object.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Bus_info_head extends StatefulWidget {
  final Future<void> Function(String) reset;
  final String bus_num;
  final String station_start;
  final String station_end;

  const Bus_info_head({super.key,required this.reset, required this.bus_num, required this.station_start,required this.station_end});

  @override
  State<Bus_info_head> createState() => _Bus_info_headState();
}

class _Bus_info_headState extends State<Bus_info_head> {



  @override
  Widget build(BuildContext context) {
    String start_bus_station = widget.station_start;
    String end_bus_station = widget.station_end;


    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 4.0,
            spreadRadius: 0.0,
            offset: const Offset(0, 2),
          )
        ],
        border: Border.all(color: Colors.black, width: 0.1), //테두리
      ),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () async {
                        await widget.reset(widget.bus_num);
                        setState(()  {
                        });
                      },
                      icon: Icon(
                        Icons.rotate_left_outlined,
                        color: Colors.green,
                      ),
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Center(
                    child: Text(
                      widget.bus_num,
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                "$start_bus_station <-> $end_bus_station",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
