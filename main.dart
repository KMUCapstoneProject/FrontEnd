import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,

      ),
      home:MyHomePage()
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> values = ['cat.jpeg','cat.jpeg','cat.jpeg','cat.jpeg','cat.jpeg','cat.jpeg','cat.jpeg','cat.jpeg','cat.jpeg'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gridview Tutorial'),
      ),
      body: Container(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, // 1개의 행에 항목을 3개씩
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1/2,
          ),
          itemCount:values.length,
          itemBuilder:(context, index){
            return Card(
              elevation:10,
              child: Center(
                child:Image.asset(values[index]),
              ),
            );
          },

        )
      )
    );
  }
}


/*
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: login_page(),
      theme:ThemeData(
        colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple,
        primary: Colors.deepOrange,
      ),
    useMaterial3:true,
    ),
    );
  }
}

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
              Center(
                child: Image(
                  image: AssetImage('images/kmu_rm_b2.png'),
                  width: 500,
                ),
              ),
              Form(
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
                                // 회원가입 버튼이 눌렸을 때 수행할 동작 추가
                              },
                              child: Text("회원가입"),
                            ),
                            TextButton(
                              onPressed: () {
                                // 비밀번호 찾기 버튼이 눌렸을 때 수행할 동작 추가
                              },
                              child: Text("비밀번호 찾기"),
                            )
                          ],
                        ),
                        ButtonTheme(
                          minWidth: 100.0,
                          height: 50.0,
                          child: ElevatedButton(
                            onPressed: () {
                              // 로그인 버튼이 눌렸을 때 수행할 동작 추가
                            },
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.deepPurple,
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
*/