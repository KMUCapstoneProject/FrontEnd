import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/Server_conn/mariaDB_server.dart';
import 'package:project_2/drawer/event_list.dart';

class event_content_page extends StatelessWidget {
  const event_content_page({super.key});

  @override
  Widget build(BuildContext context) {

    Map<String,dynamic> _psrl_data = Get.arguments;


    return Scaffold(
      appBar: AppBar(
        title: Text(_psrl_data["postId"].toString()),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: BoxDecoration(
            color: Colors.cyanAccent,
            border: Border.all(width: 3),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  child: Text(
                    "제목: ${_psrl_data["title"]}",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  child: Text(
                    "시간 : \n ${_psrl_data["startTime"]} ~ ${_psrl_data["deadline"]}",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  child: Text(
                    "장소 : ${_psrl_data["details"]}",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  child: Text(
                    "내용\n ${_psrl_data["content"]}",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await mariaDB_server().event_list_upgrade(_psrl_data["postId"]);
                        Get.off(event_list());
                      },
                      child: Text("수락"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await mariaDB_server().event_list_delete(_psrl_data["postId"]);
                        Get.off(event_list());
                      },
                      child: Text("거절"),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
