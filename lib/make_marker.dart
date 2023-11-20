import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'Building_map/Building_data.dart';
import 'package:get/get.dart';
import 'Building_map/building_map.dart';


//계명대학교 건물 ID 건물이름 ex "봉경관","바우어관"
//행사마크 ID ex "event_1","event_2"


class Make_marker {
  static building_data data_box = building_data();
  late CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController(); //커스텀윈도우 컨트롤러
  final List<Marker> _markers = [];
  final List<Marker> _event_markers =[];

  Make_marker() {
    loadData();
  }

  List<Marker> get_marker() => _markers;
  List<Marker> get_event_marker() => _event_markers;
  CustomInfoWindowController get_CIWC() => _customInfoWindowController;



  void input_marker(double Lat,double Lng,String mk_id) {
    _event_markers.add(
      Marker(
        markerId: MarkerId("$mk_id"),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueOrange,
        ),
        position: LatLng(Lat, Lng),
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
                  Text("test"),
                ],
              ),
            ),
            LatLng(Lat, Lng),
          );
        },
      ),
    );
  }

  loadData() {
    final List<LatLng> _LatLang = data_box.get_latlang();
    _customInfoWindowController.dispose();

    for (int i = 0; i < _LatLang.length; i++) {
      _markers.add(
        Marker(
          markerId: MarkerId(data_box.get_buildingName()[i]),
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
    }
  }
}
