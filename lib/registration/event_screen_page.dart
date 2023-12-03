import 'package:flutter/material.dart';
import 'package:project_2/Server_conn/mariaDB_server.dart';

class event_screen_page extends StatefulWidget {
  const event_screen_page({Key? key}) : super(key: key);

  @override
  _event_screen_page createState() => _event_screen_page();
}

class _event_screen_page extends State<event_screen_page> {
  List<String> values = ['test1.jpg','test2.jpg','test3.jpg','test4.jpg','cat.jpg','cat.jpg','cat.jpg','cat.jpg','cat.jpg']; // 프로그램 대표 이미지
  List<String> Manage_team = ['교육혁신팀', '이민다문화센터', '국제학연구소', '산학인재원행정팀',"test"]; // 담당팀
  List<String> Recruitment_period = ['2023.11.16 ~ 2023.11.27', '2023.11.14 ~ 2023.12.06', '2023.11.13 ~ 2023.11.22', '2023.11.14 ~ 2023.11.26']; // 모집기간
  List<String> Operating_period = ['2023.12.02 ~ 2023.12.14', '2023.11.29 ~ 2023.11.29', '2023.11.22 ~ 2023.11.22', '2023.11.29 ~ 2023.12.06']; // 운영기간
  List<String> Project_name = ['[빅데이터사업부]빅데이터 분석 경진대회(2차)', '2023학년도 제19회 열린 이민다문화포럼', '현대 아산나눔재단,대학내일_찾아가는 START UP 토크 콘서트', '[인성교육 프로그램]두 손으로 나누는 세상의 사랑 이야기']; // 프로젝트명
  List<dynamic> _psrl = <dynamic>[];
  List<String> start_time = [];
  List<String> end_time = [];

  @override
  void initState() {
    super.initState();
    mariaDB_server().event_registration_get2().then((value) {
      setState(() {
        _psrl = value;
      });
    });
  }

  @override
  Widget build(BuildContext context)  {
    return Scaffold(
        appBar: AppBar(
          title: Text('Gridview Tutorial'),
        ),
        body: Container(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 1개의 행에 항목을 2개씩
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1/2,
              ),
              itemCount:_psrl.length,
              itemBuilder:(context, index){
                List<String> start_time =
                _psrl[index]["startTime"].toString().split("T");
                List<String> end_time =
                _psrl[index]["deadline"].toString().split("T");
                return Card(
                  elevation:10,
                  //child: Center(
                  //  child:Image.asset(values[index]),
                  //),
                  child: Column(children: [
                    ClipRRect(
                        borderRadius : const BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          topRight: Radius.circular(16.0),
                        ),
                        child:Image.asset("images/${values[4]}",height: MediaQuery.of(context).size.height * 0.2,width: MediaQuery.of(context).size.width * 0.45,)
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(_psrl[index]["title"], style: TextStyle(fontSize:13, color:Colors.black)),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Text("담당팀: ${_psrl[index]["content"]}", style: TextStyle(fontSize:10, color:Colors.black)),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Text("모집기간: ${start_time[0]}  ${start_time[1]}\n   ~  ${end_time[0]}  ${end_time[1]}", style: TextStyle(fontSize:10, color:Colors.black)),
                          const SizedBox(
                            height: 4.0,
                          ),
                          Text("운영기간: " + Operating_period[0], style: TextStyle(fontSize:10, color:Colors.black))
                        ],
                      ),
                    )
                  ]),
                );
              },
            )
        )
    );
  }
}
