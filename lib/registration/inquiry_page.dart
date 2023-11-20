import 'package:flutter/material.dart';

class Inquiry extends StatefulWidget {
  const Inquiry({super.key});

  @override
  State<Inquiry> createState() => _InquiryState();
}

class _InquiryState extends State<Inquiry> {
  final valueList = ['시스템 문제 보고', '길 찾기 문제 보고', '질문', '요청'];
  String select = "";
  @override
  void initState() {
    super.initState();
    setState(() {
      select = valueList[0];
    });
  }

  upload() async {}
  backScrean() async {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('문의'),
        // 앱바의 왼쪽
        leading: IconButton(
          onPressed: backScrean,
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        // 앱바의 오른쪽
        actions: [
          Container(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18))),
              ),
              onPressed: upload,
              child: const Text('제출'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 80, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButton(
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
              const Text(
                '문제 설명',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const TextField(
                maxLines: 5,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: '문제를 자세히 설명해주세요',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Email',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const TextField(
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
