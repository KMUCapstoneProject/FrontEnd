import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_2/Server_conn/mariaDB_server.dart';

class Error_list extends StatefulWidget {
  const Error_list({super.key});

  @override
  State<Error_list> createState() => _Error_listState();
}

class _Error_listState extends State<Error_list> {
  List<dynamic> _psrl = <dynamic>[];

  @override
  void initState() {
    super.initState();
    mariaDB_server().messges_output().then((value) {
      setState(() {
        _psrl = value;
      });
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: _psrl.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {},
            child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 5.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    margin: EdgeInsets.all(10),
                    child: Icon(Icons.email_rounded),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        "data22",
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.check)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
