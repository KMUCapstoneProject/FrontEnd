import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Marker_event_page extends StatelessWidget {
  const Marker_event_page({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> _psal = Get.arguments;
    String _title = _psal["title"];
    List<String> _start_time  = _psal["startTime"].toString().split("T");
    List<String> _end_time  = _psal["deadline"].toString().split("T");
    print(_psal);

    return Scaffold(
      appBar: AppBar(
        title: Text("행사"),
        centerTitle: true,
        flexibleSpace: ClipPath(
          child: Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue,
                  Colors.lightBlueAccent,
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: 30, bottom: 30),
            width: MediaQuery.of(context).size.width * 0.85,
            decoration: BoxDecoration(
              border: Border.all(width: 0.2),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(width: 0.2)),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Image.network(
                      "http://friedkimchi.kdedevelop.com/downloadFile/1000000527.jpg",
                      width: MediaQuery.of(context).size.width * 0.85,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: 230,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.lightBlue,
                              border: Border.all(width: 0.2),
                              borderRadius: BorderRadius.circular(1),
                            ),
                            padding: EdgeInsets.all(3),
                            child: Text(
                              "행사 기간",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${_start_time[0]} ${_start_time[1]}"),
                              Text(" ~  ${_end_time[0]} ${_end_time[1]}"),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: 120,
                        child: Text(_psal["content"]),
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.2),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
