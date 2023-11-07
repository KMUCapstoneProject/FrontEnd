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
import 'package:project_2/road/road_data.dart';
import 'package:project_2/search_page.dart';
import 'Building_map/Building_data.dart';

class kmu_map extends StatefulWidget {
  const kmu_map({super.key});

  @override
  State<kmu_map> createState() => _kmu_mapState();
}

class _kmu_mapState extends State<kmu_map> {
  static building_data data_box = building_data();
  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  final List<Marker> _markers = data_box.get_marker();
  final List<LatLng> _LatLang = data_box.get_latlang();

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
                    Text(data_box.get_buildingName()[i]),
                    ElevatedButton(
                      onPressed: () {
                        Get.to(swiper_test2(),
                            arguments: data_box.get_buildingName()[i]);
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
      setState(() {});
    }
  }

  late GoogleMapController googleMapController;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Position>(
      // 데이터를 받아옴
      stream: Geolocator.getPositionStream(), // 현재 GPS위치를 받아옴
      builder: (context, snapshot) {
        if (snapshot.hasData && road_data().get_latlng().isNotEmpty) {
          final start = snapshot.data!;
          final end = road_data().get_latlng()[0];
          final distance = Geolocator.distanceBetween(
              start.latitude, start.longitude, end.latitude, end.longitude);
          if (distance < 18) {
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
                          });
                        },
                        child: Icon(Icons.wheelchair_pickup),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(
                            () {
                              showSearch(
                                context: context,
                                delegate: Search_page(),
                              );
                            },
                          );
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
                      )
                    ],
                  ),
                )
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
      markers: Set<Marker>.of(_markers),
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
}
