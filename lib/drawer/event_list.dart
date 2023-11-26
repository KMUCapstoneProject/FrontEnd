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
    mariaDB_server().event_list().then((value){
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
          return GestureDetector(
            onTap: () async {
              await Get.off(event_content_page(),arguments: _psrl[index]);
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
                          _psrl[index]["title"],
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
