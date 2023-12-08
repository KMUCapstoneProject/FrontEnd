import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/drawer/error_list.dart';
import 'package:project_2/drawer/event_content_page2.dart';
import 'package:project_2/drawer/event_list.dart';
import 'package:project_2/registration/event_registration_page.dart';
import 'package:project_2/registration/event_screen_page.dart';
import 'package:project_2/registration/inquiry_page.dart';
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
    print(check);
    if (check == "ADMIN") {
      return admin_page();
    } else if (check == "MANAGER") {
      return manager_page();
    } else if(check == "NORMAL") {
      return normal_user_page();
    } else{
      return user_page();
    }
  }

  Widget admin_page() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue,
                  Colors.green,
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(40.0),
                bottomLeft: Radius.circular(40.0),
              ),
            ),
            accountName: Text("닉네임 : ${user_data().get_nickname()}"),
            accountEmail: Text("email : ${user_data().get_email()}"),
          ),
          ListTile(
            leading: Icon(
              Icons.find_in_page_rounded,
              color: Colors.grey[850],
            ),
            title: Text("비교과 목록"),
            onTap: () {
              Get.to(event_screen_page());
            },
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
          ),
          ListTile(
            leading: Icon(
              Icons.find_in_page_rounded,
              color: Colors.grey[850],
            ),
            title: Text("민원함"),
            onTap: () {
              Get.to(Error_list());
            },
          )
        ],
      ),
    );
  }

  Widget manager_page() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue,
                  Colors.green,
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(40.0),
                bottomLeft: Radius.circular(40.0),
              ),
            ),
            accountName: Text("닉네임 : ${user_data().get_nickname()}"),
            accountEmail: Text("email : ${user_data().get_email()}"),
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
          ),
          ListTile(
            leading: Icon(
              Icons.find_in_page_rounded,
              color: Colors.grey[850],
            ),
            title: Text("비교과 목록"),
            onTap: () {
              Get.to(event_screen_page());
            },
          ),
          ListTile(
            leading: Icon(
              Icons.find_in_page_rounded,
              color: Colors.grey[850],
            ),
            title: Text("오류접수"),
            onTap: () {
              Get.to(Inquiry());
            },
          )
        ],
      ),
    );
  }

  Widget normal_user_page() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue,
                  Colors.green,
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(40.0),
                bottomLeft: Radius.circular(40.0),
              ),
            ),
            accountName: Text("닉네임 : ${user_data().get_nickname()}"),
            accountEmail: Text("email : ${user_data().get_email()}"),
          ),
          ListTile(
            leading: Icon(
              Icons.find_in_page_rounded,
              color: Colors.grey[850],
            ),
            title: Text("비교과 목록"),
            onTap: () {
              Get.to(event_screen_page());
            },
          ),
          ListTile(
            leading: Icon(
              Icons.find_in_page_rounded,
              color: Colors.grey[850],
            ),
            title: Text("오류접수"),
            onTap: () {
              Get.to(Inquiry());
            },
          ),
        ],
      ),
    );
  }

  Widget user_page() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue,
                  Colors.green,
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(40.0),
                bottomLeft: Radius.circular(40.0),
              ),
            ),
            accountName: Text("닉네임 : ${user_data().get_nickname()}"),
            accountEmail: Text("email : ${user_data().get_email()}"),
          )
        ],
      ),
    );
  }

}
