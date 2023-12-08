import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Error_page extends StatefulWidget {
  const Error_page({super.key});

  @override
  State<Error_page> createState() => _Error_pageState();
}

class _Error_pageState extends State<Error_page> {
  Map<String, dynamic> _psrl_data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("문의"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Container(
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            border: Border.all(width: 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "제목: ${_psrl_data["title"]}",
                style: TextStyle(fontSize: 40),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text("보낸사람: "),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20)),
                    padding: EdgeInsets.all(4),
                    child: Text(_psrl_data["senderName"]),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: Text(
                  "내용",
                  style: TextStyle(fontSize: 25),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(3),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*0.55,
                decoration: BoxDecoration(
                  border: Border.all(width: 2),
                ),
                child: Text(_psrl_data["content"]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
