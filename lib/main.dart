import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:project_2/start_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return GetMaterialApp(
      title: "map_project",
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: checkPermission(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return start_page();
        },
      ),
    );
  }
}

Future<String> checkPermission() async {
  //권한을 확인한다.
  final isLocationEnabled =
  await Geolocator.isLocationServiceEnabled(); //로케이션 서비스를 사용가능한지 확인할수있다.

  if (!isLocationEnabled) {
    return '위치 서비스를 활성화 해주세요';
  }

  LocationPermission checkedPermission =
  await Geolocator.checkPermission(); // 권한 허용상태

  if (checkedPermission == LocationPermission.denied) {
    checkedPermission = await Geolocator.requestPermission();
    if (checkedPermission == LocationPermission.denied) {
      return '위치 권한을 허가해주세요';
    }
  }
  if (checkedPermission == LocationPermission.deniedForever) {
    return '앱의 위치 권한을 세팅에서 허가해주세요.';
  }

  return "위치 권한이 허가되었습니다.";
}

