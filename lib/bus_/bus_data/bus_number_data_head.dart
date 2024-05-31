import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Bus_number_data_head extends StatelessWidget {
  final String title;
  final int? bus_station_number;
  final Function reset_page;


  Bus_number_data_head({required this.title, required this.bus_station_number,required this.reset_page});


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Row(
        children: [
          Expanded(
            child: bus_number_data_head_left(),
          ),
          Expanded(
            flex: 5,
            child: bus_number_data_head_midle(),
          ),
          Expanded(
            child: bus_number_data_head_right(),
          ),
        ],
      ),
    );
  }


  Widget bus_number_data_head_midle(){
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          // 기본 스타일 설정
          style: TextStyle(
              color: Colors.white
          ),
          children: <TextSpan>[
            TextSpan(
              text: '${bus_station_number}\n',
              style: TextStyle(fontSize: 10),
            ),
            TextSpan(
              text: '${title}\n',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget bus_number_data_head_left(){
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Align(
        alignment: Alignment.topLeft,
        child: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(Icons.arrow_back)),
      ),
    );
  }

  Widget bus_number_data_head_right(){
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Align(
        alignment: Alignment.topRight,
        child: IconButton(onPressed: (){
          reset_page(title);

        }, icon: Icon(Icons.refresh)),
      ),
    );
  }
}
