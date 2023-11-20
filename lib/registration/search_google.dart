import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';

class search_google extends StatefulWidget {
  const search_google({super.key});

  @override
  State<search_google> createState() => _search_googleState();
}

class _search_googleState extends State<search_google> {
  static late LatLng start_map = LatLng(35.855764, 128.487199); //계명대학교 좌표
  static final CameraPosition initialPosition = CameraPosition(
    //카메라 위치 선정
    target: start_map, // 경위도
    zoom: 15, // 확대 정도
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("data"),
        leading: IconButton(
          onPressed: () {
            Get.back(result: start_map);
          },
          icon: Icon(Icons.arrow_back_sharp),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width, //?????????이게 뭐지?
        child: GoogleMap(
          onTap: (value) {
            setState(() {
              start_map = value;
            });
          },
          initialCameraPosition: initialPosition,
          zoomControlsEnabled: true,
          minMaxZoomPreference: MinMaxZoomPreference(16.7499995, 30),
          markers: {
            Marker(
              markerId: MarkerId("test"),
              position: start_map,
            ),
          },
        ),
      ),
    );
  }
}
