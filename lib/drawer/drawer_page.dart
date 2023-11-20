import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/drawer/event_list.dart';
import 'package:project_2/registration/event_registration_page.dart';
import 'package:project_2/registration/registration_page.dart';
import '../login_page.dart';

class drawer_page extends StatefulWidget {
  const drawer_page({super.key});

  @override
  State<drawer_page> createState() => _drawer_pageState();
}

class _drawer_pageState extends State<drawer_page> {
  bool check = false;

  @override
  Widget build(BuildContext context) {
    if(check)
      {
        return manager();
      }
    else
      {
        return normal_user();
      }
  }

  Widget manager()
  {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("test"),
            accountEmail: Text("Email@naver.com"),
          ),
          ListTile(
            leading: Icon(
              Icons.find_in_page_rounded,
              color: Colors.grey[850],
            ),
            title: Text("행사 및 비교과 수신함"),
            onTap: () {
              Get.to(event_list());
            },
          )
        ],
      ),
    );
  }

  Widget normal_user()
  {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("test"),
            accountEmail: Text("Email@naver.com"),
          ),
          ListTile(
            leading: Icon(
              Icons.find_in_page_rounded,
              color: Colors.grey[850],
            ),
            title: Text("비교과 신청서"),
            onTap: () {
              Get.to(registration_page());
            },
          ),
          ListTile(
            leading: Icon(
              Icons.find_in_page_rounded,
              color: Colors.grey[850],
            ),
            title: Text("행사 신청서"),
            onTap: () {
              Get.to(event_registration());
            },
          )
        ],
      ),
    );
  }
}
