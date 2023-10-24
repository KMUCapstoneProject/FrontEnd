import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:get/get.dart';
import 'package:project_2/Building_map/building_map.dart';
import 'package:project_2/Building_map/drawer_page.dart';
import 'package:project_2/login_page.dart';
import 'Building_data.dart';

class kmu_map extends StatefulWidget {
  const kmu_map({super.key});

  @override
  State<kmu_map> createState() => _kmu_mapState();
}

class _kmu_mapState extends State<kmu_map> {
  static building_data data_box = new building_data();

  CustomInfoWindowController _customInfoWindowController =
  CustomInfoWindowController();

  final List<Marker> _markers = data_box.input_marker();
  final List<LatLng> _LatLang = data_box.input_latlang();

  static final LatLng start_map = LatLng(35.855764, 128.487199);
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
    loadData();
  }

  ///////

  loadData() {
    _customInfoWindowController.dispose();
    print("object");

    for (int i = 0; i < _LatLang.length; i++) {
      _markers.add(
        Marker(
          markerId: MarkerId(i.toString()),
          icon: BitmapDescriptor.defaultMarker,
          position: _LatLang[i],
          onTap: () {
            // 마커 클릭시
            _customInfoWindowController.addInfoWindow!(
              Container(
                height: 300,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(data_box.input_buildingName()[i]),
                    ElevatedButton(
                      onPressed: () {
                        Get.to(swiper_test());
                        _customInfoWindowController.hideInfoWindow!();
                      },
                      child: Text("건물내부"),
                    )
                  ],
                ),
              ),
              _LatLang[i],
            );
          },
        ),
      );
      //setState(() {});
    }
  }

  late GoogleMapController googleMapController;

  @override
  Widget build(BuildContext context) {
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
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Colors.black, width: 2),
                  color: Colors.white),
              margin: EdgeInsets.only(top: 40, left: 20, right: 20),
              width: 400,
              height: 60,
              padding: EdgeInsets.only(bottom: 10, right: 20),
              child: search_map(),
            ),
          ],
        ),
      ),
    );
  }

  final List<Polyline> test =
  <Polyline>[]; ////////////////////////////////////test
  final List<Circle> circles_test =
  <Circle>[]; ////////////////////////////////////test

  test_circles_make() {
    for (int i = 0; i < _LatLang.length; i++) {
      circles_test.add(
        Circle(
          circleId: CircleId("$i circle"),
          center: _LatLang[i],
          fillColor: Colors.blue.withOpacity(0.1),
          radius: 30,
          strokeColor: Colors.blue,
          strokeWidth: 1,
        ),
      );
    }
  }

  Widget google_option() {
    return GoogleMap(
      initialCameraPosition: initialPosition,
      markers: Set<Marker>.of(_markers),
      polylines: Set<Polyline>.of(test),
      ////////////////////////////////////////test
      circles: Set<Circle>.of(circles_test),
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

  Widget search_map() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Builder(builder: (context) {
          return Expanded(
            flex: 10,
            child: IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(
                Icons.list_outlined,
                size: 40,
              ),
            ),
          );
        }),
        Expanded(
          flex: 45,
          child: TextField(),
        ),
        Expanded(
          flex: 5,
          child: IconButton(
            onPressed: () {
              setState(
                    () {
                  _markers.add(
                    Marker(
                      markerId: MarkerId("test"),
                      icon: BitmapDescriptor.defaultMarker,
                      position: LatLng(35.857577, 128.487243),
                    ),
                  );
                  test.add(
                    Polyline(
                      polylineId: PolylineId("value"),
                      points: [
                        LatLng(35.857577, 128.487243),
                        LatLng(35.859300, 128.486937),
                        LatLng(35.859820, 128.487069),
                        LatLng(35.859679, 128.487733),
                        LatLng(35.859171, 128.487625),
                        LatLng(35.859300, 128.486937),
                      ],
                      width: 2,
                    ),
                  );
                  test_circles_make();
                },
              );
            },
            icon: Icon(
              Icons.search,
              size: 30,
            ),
          ),
        ),
      ],
    );
  }
}
