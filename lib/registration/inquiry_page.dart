import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/Server_conn/mariaDB_server.dart';

class Inquiry extends StatefulWidget {
  const Inquiry({super.key});

  @override
  State<Inquiry> createState() => _InquiryState();
}

class _InquiryState extends State<Inquiry> {
  final valueList = ['시스템 문제 보고', '길 찾기 문제 보고', '질문', '요청'];
  String select = "";

  //email 컨트롤러
  TextEditingController receiverName_ctr = TextEditingController();
  //제목 컨트롤러
  TextEditingController title_ctr = TextEditingController();
  //내용 컨트롤러
  TextEditingController content_ctr = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      select = valueList[0];
    });
  }

  upload() async {
    bool check = await mariaDB_server().messges_input(title_ctr.text, content_ctr.text, receiverName_ctr.text);
    if(check)
      {
        Get.back();
      }
    else
      {
        showPopup();
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 239, 239),
      appBar: AppBar(
        title: const Text(
          '문의하기',
          style: TextStyle(fontSize: 25),
        ),
        // 앱바의 왼쪽
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: SingleChildScrollView(
          child:
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: const Text(
                '이메일',
                style: TextStyle(fontSize: 15),
              ),
            ),
            TextField(
              controller: receiverName_ctr,
              decoration: InputDecoration(
                hintText: '이메일을 입력하세요',
                hintStyle: TextStyle(color: Colors.grey[400]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: DropdownButton(
                value: select,
                items: valueList
                    .map((e) => DropdownMenuItem(
                  value: e, // 선택 시 onChanged 를 통해 반환할 value
                  child: Text(e),
                ))
                    .toList(),
                onChanged: (value) {
                  // items 의 DropdownMenuItem 의 value 반환
                  setState(() {
                    select = value!;
                  });
                },
              ),
            ),
            Container(
                margin: const EdgeInsets.all(10),
                child: const Text(
                  '제목',
                  style: TextStyle(fontSize: 15),
                )),
            TextField(
              controller: title_ctr,
              decoration: InputDecoration(
                hintText: '제목을 입력하세요',
                hintStyle: TextStyle(color: Colors.grey[400]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Container(
                margin: const EdgeInsets.all(10),
                child: const Text(
                  '문의 내용',
                  style: TextStyle(fontSize: 15),
                )),
            TextField(
              controller: content_ctr,
              maxLines: 10,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: upload,
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        child: const Text(
                          '제출',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }

  void showPopup() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
              width: MediaQuery.of(context).size.width * 0.3,
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: Center(
                child: Text(
                  "로그인 실패",
                  style: TextStyle(fontSize: 30),
                ),
              )),
        );
      },
    );
  }


}
