import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_2/Building_map/Building_data.dart';
import 'package:project_2/search/search_page.dart';

import '../road/road_data.dart';

class search_start_page extends StatefulWidget {
  const search_start_page({super.key});

  @override
  State<search_start_page> createState() => _search_start_pageState();
}

class _search_start_pageState extends State<search_start_page> {
  List<String> test = building_data().get_buildingName();
  final controller = TextEditingController();
  final controller_2 = TextEditingController();
  bool _search = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("data"),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      child: Column(
                        children: [
                          search_bar_1(),
                          search_bar_2(),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: search_button(),
                  ),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              search_items(),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    controller.text = "현재위치";
                  });
                },
                child: Icon(Icons.gps_fixed),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 55, left: 217),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  String data = controller_2.text;
                  controller_2.text = controller.text;
                  controller.text = data;
                });
              },
              child: Icon(Icons.change_circle_outlined),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(90))
                ),
                side: BorderSide(color: Colors.grey, width: 1),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget search_bar_1() {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        hintText: "출발지점",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(15)),
          borderSide: const BorderSide(color: Colors.blue),
        ),
      ),
      onChanged: search,
      onTap: () {
        _search = true;
      },
    );
  } // search 함수 요기 있음

  Widget search_bar_2() {
    return Column(
      children: [
        TextField(
          controller: controller_2,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            hintText: "도착지점",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15)),
              borderSide: const BorderSide(color: Colors.blue),
            ),
          ),
          onChanged: search,
          onTap: () {
            _search = false;
          },
        ),
      ],
    );
  } // search 함수 요기 있음

  Widget search_items() {
    return Expanded(
      child: ListView.builder(
        itemCount: test.length,
        itemBuilder: (context, index) {
          final building = test[index];
          return ListTile(
            title: Text(building),
            onTap: () {
              setState(
                    () {
                  if (_search) {
                    controller.text = building;
                  } else {
                    controller_2.text = building;
                  }
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget search_button() {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          String start = controller.text;
          String end = controller_2.text;

          switch(error_check(start,end))
          {
            case 0 : break;
            case 1 : break;
            case 2 : break;
          }
          if(true)
            {
              road_data().reset_road();
              road_data().input_road(controller.text,controller_2.text);
            }
        });
      },
      child: Icon(
        Icons.search,
        size: 50,
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        side: BorderSide(color: Colors.grey, width: 1),
        fixedSize: Size(100, 118),
      ),
    );
  } // 검색버튼

  void search(String query) {
    // 글자 입력마다 검색창 오브젝트 변경
    List<String> suggestions =
    building_data().get_buildingName().where((searchResult) {
      return searchResult.contains(query);
    }).toList(); //검색창에 글자를 넣을때 마다 리스트에 그 글자와 관련된 내용이 있으면 리스트에 추가
    setState(() {
      test = suggestions;
    });
  }

  int error_check(String start,String end)
  {

    return 1;
  }
}
