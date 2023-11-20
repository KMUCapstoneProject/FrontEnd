import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/drawer/event_content_page.dart';

class event_list extends StatefulWidget {
  const event_list({super.key});

  @override
  State<event_list> createState() => _event_list();
}

class _event_list extends State<event_list> {
  var titlelist = [
    "test 행사",
    "test1 비교과",
    "test2",
    "test3",
    "test4",
    "test5",
    "test6",
    "test7",
    "test8",
    "test9",
    "test10",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("data"),
      ),
      body: ListView.builder(
        itemCount: titlelist.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              Get.to(event_content_page(),arguments: titlelist[index]);
            },
            child: Card(
              child: Row(
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset("images/kmu_1.png"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          titlelist[index],
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        )
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
