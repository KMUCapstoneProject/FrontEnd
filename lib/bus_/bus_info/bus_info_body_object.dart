import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class Bus_info_body_object_class {

  static final Bus_info_body_object_class _Biboc = Bus_info_body_object_class._internal();
  factory Bus_info_body_object_class() => _Biboc;
  Bus_info_body_object_class._internal() {}
  int number = 5;


  void now_bus_target(int number)
  {
    this.number = number;
  }

  int now_bus_target1(){
    return number;
  }


  Widget _Circular_object() {
    return Row(
      children: [
        Container(
          width: 50,
          child: Center(
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border(
                  left: BorderSide(color: Colors.amber, width: 3),
                  right: BorderSide(color: Colors.amber, width: 3),
                  top: BorderSide(color: Colors.amber, width: 3),
                  bottom: BorderSide(color: Colors.amber, width: 3),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _Bus_icon() {
    return Row(
      children: [
        Container(
          width: 50,
          child: Center(
            child: Icon(
              Icons.directions_bus,
              size: 26,
            ),
          ),
        ),
      ],
    );
  }

  Widget bus_station_mid(String bus_station_name,bool check){
    return Row(
      children: [
        SizedBox(
          width: 80,
          child: Center(
            child: (check)?Text("버스번호"):Text(""),
          ),
        ),
        Stack(
          children: [
            Container(
              width: 50,
              child: Center(
                child: Container(
                  width: 6,
                  color: Colors.amber,
                ),
              ),
            ),
            Container(
              height: 80,
              child: (check)?_Bus_icon():_Circular_object(),
            )
          ],
        ),
        Container(
          child: Text(bus_station_name),
        )
      ],
    );
  }

  Widget bus_station_start(String bus_station_name,bool check){
    return Row(
      children: [
        SizedBox(
          width: 80,
          child: Center(
            child: (check)?Text("버스번호"):Text(""),
          ),
        ),
        Stack(
          children: [
            Container(
              width: 50,
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20),
                    border: Border(
                      left: BorderSide(color: Colors.grey, width: 2),
                      right: BorderSide(color: Colors.grey, width: 2),
                      top: BorderSide(color: Colors.grey, width: 2),
                      bottom: BorderSide(color: Colors.grey, width: 2),
                    ),
                  ),
                  child: Text("기점"),
                ),
              ),
            ),
            if(check)
              _Bus_icon(),
          ],
        ),
        Container(
          child: Text(bus_station_name),
        ),
      ],
    );
  }


  Widget bus_station_end(String bus_station_name,bool check){
    return Row(
      children: [
        SizedBox(
          width: 80,
          child: Center(
            child: (check)?Text("버스번호"):Text(""),
          ),
        ),
        Stack(
          children: [
            Container(
              width: 50,
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20),
                    border: Border(
                      left: BorderSide(color: Colors.grey, width: 2),
                      right: BorderSide(color: Colors.grey, width: 2),
                      top: BorderSide(color: Colors.grey, width: 2),
                      bottom: BorderSide(color: Colors.grey, width: 2),
                    ),
                  ),
                  child: Text("종점"),
                ),
              ),
            ),
          ],
        ),
        Container(
          child: Text(bus_station_name),
        ),
      ],
    );
  }






}

