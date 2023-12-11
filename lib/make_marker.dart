
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_2/Server_conn/mariaDB_server.dart';
import 'package:project_2/registration/marker_event_page.dart';
import 'Building_map/Building_data.dart';
import 'package:get/get.dart';
import 'Building_map/building_map.dart';
import 'package:label_marker/label_marker.dart';

//계명대학교 건물 ID 건물이름 ex "봉경관","바우어관"
//행사마크 ID ex "event_1","event_2"

class Make_marker {
  static building_data data_box = building_data();
  late CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController(); //커스텀윈도우 컨트롤러
  late Set<Marker> _markers = {};

  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  Make_marker() {
    addCustomIcon();
    loadData();
  }

  Set<Marker> get_marker() => _markers;

  CustomInfoWindowController get_CIWC() => _customInfoWindowController;

  loadData() async {
    input_marker();
    input_event_marker();
  }

  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), "images/kmu_marker2.png")
        .then(
          (icon) {
        markerIcon = icon;
      },
    );
  }

  void input_marker() {
    final List<LatLng> _LatLang = data_box.get_latlang();
    _customInfoWindowController.dispose();

    for (int i = 0; i < _LatLang.length; i++) {
      String buildingName = data_box.get_buildingName()[i];
      _markers.addLabelMarker(
        LabelMarker(
          label: buildingName,
          markerId: MarkerId(buildingName),
          position: _LatLang[i],
          backgroundColor: Colors.green,
          textStyle: TextStyle(fontSize: 40),
          onTap: () {
            // 마커 클릭시
            windowform_page(data_box.get_buildingName()[i], _LatLang[i]);
          },
        ),
      );
    }
  }

  Future<void> input_event_marker() async {
    List<dynamic> _event_data = <dynamic>[];
    await mariaDB_server().event_registration_get1().then((value) {
      _event_data = value;
    });

    for (int i = 0; i < _event_data.length; i++) {
      LatLng LL =
      LatLng(_event_data[i]["latitude"], _event_data[i]["longitude"]);
      _markers.add(
        Marker(
          icon: markerIcon,
          markerId: MarkerId(_event_data[i]["postId"].toString()),
          position: LL,
          onTap: () {
            windowform_event_page(_event_data[i], LL);
          },
        ),
      );
    }
  }

  dynamic windowform_page(String building_name, LatLng location) {
    return _customInfoWindowController.addInfoWindow!(
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
            Text(building_name),
            ElevatedButton(
              onPressed: () {
                Get.to(swiper_test2(), arguments: building_name);
                _customInfoWindowController.hideInfoWindow!();
              },
              child: Text("건물내부"),
            )
          ],
        ),
      ),
      location,
    );
  }

  dynamic windowform_event_page(Map<String,dynamic> event_data, LatLng location) {
    return _customInfoWindowController.addInfoWindow!(
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
            Text(event_data["title"]),
            ElevatedButton(
              onPressed: () {
                _customInfoWindowController.hideInfoWindow!();
                Get.to(Marker_event_page(),arguments: event_data);
              },
              child: Text("행사내용"),
            )
          ],
        ),
      ),
      location,
    );
  }
}
