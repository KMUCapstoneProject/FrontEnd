import 'package:project_2/bus_/Bus_dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../bus_info/bus_info_main.dart';

class Bus_number_data_body extends StatelessWidget {
  final List<Map<String, int>>? bus_number;
  final Map<String, dynamic>? result;

  Bus_number_data_body({required this.bus_number, required this.result});


  List<String> findKeysByPartialKey(Map<String, dynamic>? map, String partialKey) {
    List<String> keys = [];

    map?.forEach((key, value) {
      if (key.contains(partialKey)) {
        keys.add(key);
      }
    });

    return keys;
  }


  @override
  Widget build(BuildContext context) {



    return Container(
      color: Colors.grey[300],
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: bus_number?.length,
        itemBuilder: (context, index) {
          String name = bus_number![index].keys.first;
          String time;
          String now_point;



          if (result!.containsKey(bus_number![index].keys.first)) {
            time = result?[bus_number![index].keys.first]["arrtime"];
            now_point =
                result?[bus_number![index].keys.first]["arrprevstationcnt"];
            //print(time);
          } else {
            time = "현재없음";
            now_point = "       ";
          }

          if(bus_number![index].keys.first=="성서2"){
            List<String> matchingKeys = findKeysByPartialKey(result, "성서2");
            print(matchingKeys);
            if(matchingKeys.isEmpty)
              {
                name = "성서2";
                time = "현재없음";
                now_point = "       ";

              }
            else{
              name = matchingKeys[0];
              time = result?[name]["arrtime"];
              now_point = result?[name]["arrprevstationcnt"];
            }
          }


          return Padding(
            padding: const EdgeInsets.all(1.0),
            child: Container(
              height: 60,
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    flex: 10,
                    child: Container(
                      child: Icon(Icons.star_border),
                    ),
                  ),
                  Expanded(
                    flex: 50,
                    child: GestureDetector(
                      onTap: () {
                        if(name != "성서2")
                          {
                            print("kladgjkladgjkldasjgkladsjgklajgkdasg");
                            print("number data: ${bus_number?[index][name]}");

                            if(name.contains("성서2"))
                              {
                                print(bus_number?[index]["성서2"]);

                                Get.to(
                                  Bus_info_main(),
                                  arguments: [name,bus_number?[index]["성서2"]],
                                );
                              }
                            else{
                              Get.to(
                                Bus_info_main(),
                                arguments: [name,bus_number?[index][name]],
                              );
                            }
                          }
                      },
                      child: Container(
                        child: Text(
                          name,
                          style: TextStyle(fontSize: 20, color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 25,
                    child: Text(time),
                  ),
                  Expanded(
                    flex: 20,
                    child: Text(
                      now_point,
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: Icon(Icons.watch_later_outlined),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
