import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/registration_page.dart';
import '../login_page.dart';

class drawer_page extends StatefulWidget {
  const drawer_page({super.key});

  @override
  State<drawer_page> createState() => _drawer_pageState();
}
class _drawer_pageState extends State<drawer_page> {
  int change_test = 1;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          tesst(change_test),
          ListTile(
            leading: Icon(
              Icons.find_in_page_rounded,
              color: Colors.grey[850],
            ),
            title: change_test == 1 ? Text("행사 신청서") : Text("data"),
            onTap: () {
              Get.to(registration_page());
            },
          ),
          ListTile(
            leading: Icon(
              Icons.find_in_page_rounded,
              color: Colors.grey[850],
            ),
            title: Text("비교과 신청서"),
            onTap: null,
          ),
        ],
      ),
    );
  }

  Widget drawer_page_sort(String box)
  {
    switch(box)
    {
      case "vip" : return Drawer(

        );
      default :
        return Drawer(

        );
    }
  }

  Widget tesst(int a) {
    if (a == 2) {
      return UserAccountsDrawerHeader(
        accountName: Text("test"),
        accountEmail: Text("Email@naver.com"),
      );
    } else {
      return Container(
        color: Colors.blue,
        height: 190,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await Get.to(login_page());
                  setState(() {
                    change_test = 2;
                  });
                },
                child: Text("login"),
              ),
            ],
          ),
        ),
      );
    }
  }
}

