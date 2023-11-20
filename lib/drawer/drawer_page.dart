import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/drawer/event_list.dart';
import 'package:project_2/registration/event_registration_page.dart';
import 'package:project_2/registration/registration_page.dart';
import 'package:project_2/user_data.dart';
import '../login_page.dart';

class drawer_page extends StatefulWidget {
  const drawer_page({super.key});

  @override
  State<drawer_page> createState() => _drawer_pageState();
}

class _drawer_pageState extends State<drawer_page> {
  String check = user_data().get_roles();

  @override
  Widget build(BuildContext context) {
    if(check=="admin")
      {
        return admin_page();
      }
    else if(check == "manager")
      {
        return manager_page();
      }
    else
      {
        return normal_user_page();
      }
  }

  Widget admin_page()
  {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user_data().get_nickname()),
            accountEmail: Text(user_data().get_email()),
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

  Widget manager_page()
  {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user_data().get_nickname()),
            accountEmail: Text(user_data().get_email()),
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

  Widget normal_user_page()
  {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user_data().get_nickname()),
            accountEmail: Text(user_data().get_email()),
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
