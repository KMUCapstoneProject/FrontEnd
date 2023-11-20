import 'package:flutter/material.dart';
import 'package:project_2/Server_conn/mariaDB_server.dart';

class member_make extends StatefulWidget {
  const member_make({super.key});

  @override
  State<member_make> createState() => _member_makeState();
}

class _member_makeState extends State<member_make> {
  var _helper_text = "";
  var _overlap = "";
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController paword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("회원가입"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(child: membership()),
      ),
    );
  }

  Column membership() {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
          padding: EdgeInsets.only(left: 30, right: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                child: buildEmail(),
              ),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("중복확인"),
                ),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 30, right: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                child: buildNickname(),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          padding: EdgeInsets.only(left: 30, right: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                child: buildPassword(),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          width: 150,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                mariaDB_server().create_member(email.text, name.text, paword.text);
              });
            },
            child: Text(
              "가입완료",
              style: TextStyle(fontSize: 23),
            ),
          ),
        )
      ],
    );
  }

  Widget buildEmail() => TextField(
        controller: email,
        decoration: InputDecoration(
          labelText: 'Email',
          //border: OutlineInputBorder(), // 입력창 감싸기
          helperText: '$_helper_text',
        ),
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.emailAddress,
      );

  /*Widget buildCertified() => TextField(
    //textAlign: TextAlign.center, 클릭했을떄 타이핑 위치를 조절함
    decoration: InputDecoration(
      labelText: '인증번호',
    ),
    keyboardType: TextInputType.text,
    obscureText: true,
  );*/

  Widget buildNickname() => TextField(
        //textAlign: TextAlign.center, 클릭했을떄 타이핑 위치를 조절함
        controller: name,
        decoration: InputDecoration(
          labelText: '닉네임',
        ),
        keyboardType: TextInputType.name,
      );

  Widget buildPassword() => TextField(
        //textAlign: TextAlign.center, 클릭했을떄 타이핑 위치를 조절함
        controller: paword,
        decoration: InputDecoration(
          labelText: '비밀번호',
          helperText: '$_overlap',
        ),
        keyboardType: TextInputType.text,
        obscureText: true,
      );

/*
  Widget buildPassword_chack() => TextField(
    //textAlign: TextAlign.center, 클릭했을떄 타이핑 위치를 조절함
    decoration: InputDecoration(
      labelText: '비밀번호 확인',
    ),
    keyboardType: TextInputType.text,
    obscureText: true,
  );
  */
}
