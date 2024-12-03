import 'dart:ui';

import 'package:dio/dio.dart';

class Bus_dio{

  late List<dynamic> box;

  void testtest()async{
    try{
      var respon = await Dio().get("http://27.113.54.21:20143/api/subway-schedules");
      print(respon.data);

    }catch(e){
      print(e);
    }
  }

  Future<List<Map<String, String>>?> Bus_now_traget(String bus_number) async {


    try{
      var respon = await Dio().get("http://27.113.54.21:20143/api/RouteBusLcList?pageNo=1&numOfRows=25&routeId=${bus_number}");
      Map<String,dynamic> test_box = respon.data;
      print("test_data = ${test_box}");
      // 'item'이 List<Map<String, dynamic>> 타입이라고 가정하고 이를 List<Map<String, String>>으로 변환
      List<dynamic> items = test_box["item"];

      // 변환 작업
      List<Map<String, String>> busInfo = items.map((item) {
        // 각 item을 Map<String, String>으로 변환
        return Map<String, String>.from(item);
      }).toList();

      return busInfo;
    }catch(e){
      print(e);
      return null;
    }

  }



  Future<Map<String, dynamic>> Bus_get(String nodenm) async {

    try{
      Map<String, dynamic> busStop ={};
      var respon = await Dio().get("http://27.113.54.21:20143/api/bus-arrival-info");
      box = respon.data;

      for(int a= 0;a<box.length;a++)
        {
          if(box[a]["nodenm"] == nodenm)
          {
            String routeno = box[a]["routeInfo"];
            if (busStop.keys.contains(routeno)) {
              dynamic tmp = busStop[routeno];

              String tmpArrprev = tmp["arrprevstationcnt"];
              String currArrprev = box[a]["arrprevstationcnt"];
              int tmpArrPrevInt = int.parse(tmpArrprev.split(" ")[0]);
              int currArrPrevInt = int.parse(currArrprev.split(" ")[0]);

              if (tmpArrPrevInt > currArrPrevInt) {
                busStop.remove(routeno);
                busStop[routeno] = box[a];
              }

            } else {
              busStop[routeno] = box[a];
            }
          }
        }

      /*
      for(dynamic tmp in busStop.keys)
      {
        print(busStop[tmp]);
      }

       */
      print(busStop);

      return busStop;
    }catch(e){
      print(e);
      return {};
    }
  }

}