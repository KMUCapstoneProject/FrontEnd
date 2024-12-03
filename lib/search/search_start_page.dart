import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_2/Building_map/Building_data.dart';
import 'package:project_2/search/search_page.dart';
import 'package:get/get.dart';
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
  Color _borderColor = Colors.grey;
  Color _borderColor1 = Colors.grey;
  Color _borderColor2 = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("검색"),
        centerTitle: true,
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
              ),
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
        focusedBorder: OutlineInputBorder( //TextField 클릭시 창 테두리 style
          borderRadius: BorderRadius.only(topLeft: Radius.circular(15)),
          borderSide: BorderSide(color: Colors.blue,width: 3.0),
        ),
        enabledBorder: OutlineInputBorder( //TextField 창 테두리 style
          borderRadius: BorderRadius.only(topLeft: Radius.circular(15)),
          borderSide: BorderSide(color: _borderColor1,width: 1.0),
        ),
      ),
      onChanged: search,
      onTap: () {
        _borderColor1 = Colors.grey;
        _search = true;
        search("");
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
            focusedBorder: OutlineInputBorder( //TextField 클릭시 창 테두리 style
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15)),
              borderSide: BorderSide(color: Colors.blue,width: 3.0),
            ),
            enabledBorder: OutlineInputBorder( //TextField 창 테두리 style
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15)),
              borderSide: BorderSide(color: _borderColor2,width: 1.0),
            ),
          ),
          onChanged: search,
          onTap: () {
            _borderColor2 = Colors.grey;
            _search = false;
            search("");
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
    return GestureDetector(
      child: OutlinedButton(
        onPressed: () {
          FocusScope.of(context).unfocus(); //키보드 내리기
          setState(() {
            String start = controller.text;
            String end = controller_2.text;
            error_check(start, end);
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

  void error_check(String start,String end) {
    List<String> data = [start,end];
    bool a = test.contains(start);
    bool b = test.contains(end);
    if((a|| start == "현재위치") && b )
      {
        Get.back(result: data);
      }
    else if((!a|| start != "현재위치") && b)
      {
        setState(() {
          _borderColor1 = Colors.red;
        });
      }
    else if((a|| start == "현재위치") && !b)
      {
        setState(() {
          _borderColor2 = Colors.red;
        });
      }
    else
      {
        setState(() {
          _borderColor1 = Colors.red;
          _borderColor2 = Colors.red;
        });
      }
  }
}
