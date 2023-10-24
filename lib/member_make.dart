import 'package:flutter/material.dart';

class member_make extends StatefulWidget {
  const member_make({super.key});

  @override
  State<member_make> createState() => _member_makeState();
}

class _member_makeState extends State<member_make> {
  var _helper_text = "";
  var _overlap = "";

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
      //mainAxisAlignment: MainAxisAlignment.center,
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
                child: Container(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(
                            () {
                          if (_helper_text == "인증완료") {
                            _helper_text = "인증실패";
                          } else {
                            _helper_text = "인증완료";
                          }
                        },
                      );
                    },
                    child: Text(
                      "인증",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 30, right: 30),
          child: buildCertified(),
        ),
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
                child: buildNickname(),
              ),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () {
                    setState(
                          () {
                        if (_overlap == "중복없음") {
                          _overlap = "중복인 아이디";
                        } else {
                          _overlap = "중복없음";
                        }
                      },
                    );
                  },
                  child: Text(
                    "중복확인",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 30, right: 30),
          child: buildPassword(),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: buildPassword_chack()),
        SizedBox(
          height: 30,
        ),
        Container(
          width: 150,
          height: 50,
          child: ElevatedButton(
            onPressed: () {},
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
    decoration: InputDecoration(
      labelText: 'Email',
      //border: OutlineInputBorder(), // 입력창 감싸기
      helperText: '$_helper_text',
    ),
    textInputAction: TextInputAction.done,
    keyboardType: TextInputType.emailAddress,
  );

  Widget buildCertified() => TextField(
    //textAlign: TextAlign.center, 클릭했을떄 타이핑 위치를 조절함
    decoration: InputDecoration(
      labelText: '인증번호',
    ),
    keyboardType: TextInputType.text,
    obscureText: true,
  );

  Widget buildNickname() => TextField(
    //textAlign: TextAlign.center, 클릭했을떄 타이핑 위치를 조절함
    decoration: InputDecoration(
      labelText: '닉네임',
      helperText: "$_overlap",
    ),
    keyboardType: TextInputType.text,
    obscureText: true,
  );

  Widget buildPassword() => TextField(
    //textAlign: TextAlign.center, 클릭했을떄 타이핑 위치를 조절함
    decoration: InputDecoration(
      labelText: '비밀번호',
    ),
    keyboardType: TextInputType.text,
    obscureText: true,
  );

  Widget buildPassword_chack() => TextField(
    //textAlign: TextAlign.center, 클릭했을떄 타이핑 위치를 조절함
    decoration: InputDecoration(
      labelText: '비밀번호 확인',
    ),
    keyboardType: TextInputType.text,
    obscureText: true,
  );
}
