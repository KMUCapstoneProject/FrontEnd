import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/Server_conn/mariaDB_server.dart';

import 'member_make.dart';

class login_page extends StatefulWidget {
  const login_page({super.key});

  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

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
                          controller: email,
                          decoration: InputDecoration(labelText: 'Eamil'),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        TextField(
                          controller: password,
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
                            onPressed: () async {
                               bool logins_succes = await mariaDB_server().login(email.text, password.text);
                               if(logins_succes)
                                 {
                                   setState(() {
                                     Get.back();
                                   });
                                 }
                               else
                                 {
                                   showPopup();
                                 }
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


  void showPopup()
  {
    showDialog(context: context, builder: (context){
      return Dialog(
        child: Container(
          width: MediaQuery.of(context).size.width*0.3,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white
          ),
          child: Center(
            child: Text("로그인 실패",style: TextStyle(fontSize: 30),),
          )
        ),
      );
    });
  }

}
