import 'package:geolocator/geolocator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:get/get.dart';
import 'package:project_2/Server_conn/mariaDB_server.dart';
import 'package:project_2/drawer/drawer_page.dart';
import 'package:project_2/google_map_page/custom_path.dart';
import 'package:project_2/login_page.dart';
import 'package:project_2/make_marker.dart';
import 'package:project_2/road/road_data.dart';
import 'package:project_2/search/search_page.dart';
import 'package:project_2/search/search_start_page.dart';
import 'package:project_2/user_data.dart';
import '../Building_map/Building_data.dart';
import 'package:label_marker/label_marker.dart';

class kmu_map extends StatefulWidget {
  const kmu_map({super.key});

  @override
  State<kmu_map> createState() => _kmu_mapState();
}

class _kmu_mapState extends State<kmu_map> {
  static Make_marker make_marker = Make_marker();
  static CustomInfoWindowController _customInfoWindowController =
      make_marker.get_CIWC();
  final Set<Marker> _markers = make_marker.get_marker();
  late GoogleMapController googleMapController;

  static final LatLng start_map = LatLng(35.855764, 128.487199); //계명대학교 좌표
  static final CameraPosition initialPosition = CameraPosition(
    //카메라 위치 선정
    target: start_map, // 경위도
    zoom: 15, // 확대 정도
  );

  ////지도 커스텀 영역
  String _mapStyle = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
  }

  int count = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: Text(
          "계명여지도",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontFamily: 'notosanscjkkr',
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    setState(
                      () {
                        road_data().reset_road();
                        _successMessage(context);
                      },
                    );
                  },
                  icon: Icon(Icons.change_circle_outlined),
                )
              ],
            ),
          ),
        ],
        flexibleSpace: ClipPath(
          child: Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue,
                  Colors.green,
                ],
              ),
            ),
          ),
        ),
      ),
      //길 안내 버튼
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.navigation,
        ),
        backgroundColor: Colors.blue,
        onPressed: () async {
          final data = await Get.to(search_start_page());
          setState(() {
            if (data is List) {
              road_data().reset_road();
              road_data().input_road(data[0], data[1]);
            } else {}
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      //드로우 페이지
      drawer: drawer_page(),
      //바텀 버튼
      bottomNavigationBar: bottom_button(),
      body: StreamBuilder<Position>(
        // 데이터를 받아옴
        stream: Geolocator.getPositionStream(), // 현재 GPS위치를 받아옴
        builder: (context, snapshot) {
          //GPS가 원안에 들어 오면 원이 사라지는 코드
          if (snapshot.hasData) {
            final now_location = snapshot.data!;
            road_data().input_now_location(
                now_location.latitude, now_location.longitude);
          }
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
            child: Stack(
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
              ],
            ),
          );
        },
      ),
    );
  }

  Widget google_option() {
    return GoogleMap(
      initialCameraPosition: initialPosition,
      markers: _markers,
      //Set<Marker>.of(_sum_markers),
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
      minMaxZoomPreference: MinMaxZoomPreference(16.75, 30),
    );
  }

  //화면 이동하는 방법
  void goToPlace(String building_name) {
    LatLng location = building_data().building_change_latlang(building_name);
    googleMapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: location, zoom: 10),
    ));
    windowform(building_name, location);
  }

  void windowform(String building_name, LatLng location) {
    make_marker.windowform_page(building_name, location);
  }

  //바텀 버튼 메뉴
  Widget bottom_button() {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 10,
      child: Container(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.accessible,
                        color: Colors.blue,
                      ),
                      Text("휠체어"),
                    ],
                  ),
                ),
                Builder(builder: (context) {
                  return MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.list,
                          color: Colors.blue,
                        ),
                        Text("메뉴"),
                      ],
                    ),
                  );
                }),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    setState(() async {
                      String building_name = await showSearch(
                          context: context, delegate: Search_page());
                      goToPlace(building_name);
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.blue,
                      ),
                      Text("건물 검색"),
                    ],
                  ),
                ),
                MaterialButton(
                  minWidth: 40,
                  onPressed: () async {
                    if (!user_data().get_login_check()) {
                      await Get.to(login_page());
                    } else {
                      user_data().reset_login_data();
                      await mariaDB_server().logout();
                      await Get.to(login_page());
                    }
                    setState(() {});
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        color: user_data().get_login_check()
                            ? Colors.red
                            : Colors.blue,
                      ),
                      user_data().get_login_check()
                          ? Text("로그아웃")
                          : Text("로그인"),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _successMessage(BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 1),
        backgroundColor: Colors.white,
        content: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          height: 40,
          color: Colors.cyanAccent,
        ),
      ),
    );
  }
}
