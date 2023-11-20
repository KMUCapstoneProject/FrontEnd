import 'package:geolocator/geolocator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:get/get.dart';
import 'package:project_2/Building_map/building_map.dart';
import 'package:project_2/drawer/drawer_page.dart';
import 'package:project_2/login_page.dart';
import 'package:project_2/make_marker.dart';
import 'package:project_2/road/road_data.dart';
import 'package:project_2/search/search_page.dart';
import 'package:project_2/search/search_start_page.dart';
import 'Building_map/Building_data.dart';

class kmu_map extends StatefulWidget {
  const kmu_map({super.key});

  @override
  State<kmu_map> createState() => _kmu_mapState();
}

class _kmu_mapState extends State<kmu_map> {
  static Make_marker make_marker = Make_marker();
  static CustomInfoWindowController _customInfoWindowController =
      make_marker.get_CIWC();
  final List<Marker> _markers = make_marker.get_marker();
  final List<Marker> _event_markers = make_marker.get_event_marker();
  late List<Marker> _sum_markers = [];
  late GoogleMapController googleMapController;

  static final LatLng start_map = LatLng(35.855764, 128.487199); //계명대학교 좌표
  static final CameraPosition initialPosition = CameraPosition(
    //카메라 위치 선정
    target: start_map, // 경위도
    zoom: 15, // 확대 정도
  );

  void sum_mk() {
    _sum_markers = _markers + _event_markers;
  }

  ////지도 커스텀 영역
  String _mapStyle = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
    sum_mk();
  }

  int count = 1;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Position>(
      // 데이터를 받아옴
      stream: Geolocator.getPositionStream(), // 현재 GPS위치를 받아옴
      builder: (context, snapshot) {
        //GPS가 원안에 들어 오면 원이 사라지는 코드
        if (snapshot.hasData && road_data().get_latlng().isNotEmpty) {
          final start = snapshot.data!; //실시간 GPS 좌표
          final end = road_data().get_latlng()[0];
          final distance = Geolocator.distanceBetween(
              start.latitude, start.longitude, end.latitude, end.longitude);
          if (distance < 30) {
            road_data().reset_road();
          }
        }
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            drawer: drawer_page(),
            body: Stack(
              children: [
                Container(
                  child: google_option(), //구글 지도설정
                ),
                CustomInfoWindow(
                  //infoWindow 크기랑 설정
                  controller: _customInfoWindowController,
                  height: 100,
                  width: 200,
                  offset: 35,
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            road_data().input_road2("봉경관");
                            _goToPlace();
                          });
                        },
                        child: Icon(Icons.wheelchair_pickup),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final data = await Get.to(search_start_page());
                          setState(() {
                            if (data is List) {
                              road_data().reset_road();
                              road_data().input_road(data[0], data[1]);
                            } else {}
                          });
                        },
                        child: Icon(Icons.search),
                      ),
                      Builder(
                        builder: (context) {
                          return ElevatedButton(
                              onPressed: () {
                                Scaffold.of(context).openDrawer();
                              },
                              child: Icon(Icons.list_outlined));
                        },
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            road_data().reset_road();
                          });
                        },
                        child: Text("reset"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.to(login_page());
                        },
                        child: Text("login"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (count == 1) {
                              make_marker.input_marker(
                                  35.854622, 128.487165, "event_1");
                              count++;
                            } else if (count == 2) {
                              make_marker.input_marker(
                                  35.855622, 128.487165, "event_2");
                            }
                            sum_mk();
                          });
                        },
                        child: Text("marker_test"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget google_option() {
    return GoogleMap(
      initialCameraPosition: initialPosition,
      markers: Set<Marker>.of(_sum_markers),
      polylines: Set<Polyline>.of(road_data().get_line()),
      circles: Set<Circle>.of(road_data().get_circles()),
      myLocationEnabled: true,
      onMapCreated: (GoogleMapController controller) {
        googleMapController = controller;
        googleMapController.setMapStyle(_mapStyle);
        _customInfoWindowController.googleMapController = controller;
      },
      onTap: (postiton) {
        FocusScope.of(context).unfocus();
        _customInfoWindowController.hideInfoWindow!();
      },
      onCameraMove: (postition) {
        _customInfoWindowController.onCameraMove!();
      },
      zoomControlsEnabled: true,
      minMaxZoomPreference: MinMaxZoomPreference(16.7499995, 30),
    );
  }

  //화면 이동하는 방법
  void _goToPlace() {
    final double lat = 35.855764;
    final double lng = 128.487199;
    googleMapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(lat, lng), zoom: 12),
    ));
  }
}
