import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/Server_conn/mariaDB_server.dart';
import 'package:project_2/drawer/event_content_page.dart';

class event_list extends StatefulWidget {
  const event_list({super.key});

  @override
  State<event_list> createState() => _event_list();
}

class _event_list extends State<event_list> {
  List<dynamic> _psrl = <dynamic>[];
  bool loading = false;

  void initState() {
    super.initState();
    mariaDB_server().event_list().then((value) {
      setState(() {
        _psrl = value;
        loading = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: loading ? Text("비교과 및 행사 수신함") : Text("loading..."),
      ),
      body: ListView.builder(
        itemCount: _psrl.length,
        itemBuilder: (context, index) {
          String categrty = _psrl[index]["categoryId"] == 1 ? "행사" : "비교과";
          List<String> start_time =
              _psrl[index]["startTime"].toString().split("T");
          List<String> end_time =
              _psrl[index]["deadline"].toString().split("T");
          return GestureDetector(
            onTap: () async {
              await Get.off(event_content_page(), arguments: _psrl[index]);
            },
            child: Card(
              margin: EdgeInsets.only(left: 10,right: 10),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(40.0),
                        ),
                        color: categrty == "비교과" ? Colors.green : Colors.blue),
                    child: Center(
                      child: Text(
                        "${categrty}",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${_psrl[index]["title"]}",
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "기간 :  ${start_time[0]} ${start_time[1]}",
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "  ~  ${end_time[0]} ${end_time[1]}",
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
