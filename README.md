# FrontEnd
// 김근형 test
//230910 이진호
// 우종민test

import 'package:flutter/material.dart';
import 'package:project_1/google_map.dart';
import 'package:project_1/member_make.dart';
import 'package:get/get.dart';

class login_page extends StatefulWidget {
  const login_page({super.key});

  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 50)),
              Center( //사진부분
                child: Image(
                  image: AssetImage('images/kmu_rm_b2.png'),
                  width: 500,
                ),
              ),
              Form(
                // textfile로 구현할떄 쓰기 좋음
                child: Theme(
                  data: ThemeData(
                    primaryColor: Colors.teal,
                    inputDecorationTheme: InputDecorationTheme(
                      labelStyle: TextStyle(color: Colors.teal, fontSize: 15.0),
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(40),
                    child: Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(labelText: 'ID'),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        TextField(
                          decoration: InputDecoration(labelText: 'Password'),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                        ),
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                Get.to(member_make());
                              },
                              child: Text("회원가입"),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text("비밀번호 찾기"),
                            )
                          ],
                        ),
                        ButtonTheme(
                          minWidth: 100.0,
                          height: 50.0,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.to(kmu_map()); // 페이지 이동
                            },
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 35.0,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

