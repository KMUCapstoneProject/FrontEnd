import 'dart:ui';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:custom_info_window/custom_info_window.dart';

class building_data {

  static final building_data _instance = building_data._internal();
  factory building_data(){
    return _instance;
  }
  building_data._internal(){
    input_building_data();
  }

  CustomInfoWindowController _customInfoWindowController =
  CustomInfoWindowController();
  final List<LatLng> _LatLang = <LatLng>[];
  final List<String> _buildingName = <String>[];
  final List<int> _floors_low = <int>[];
  final List<int> _floors_height = <int>[];

  /// Marker정보를 추가하는 함수.
  ///
  /// latLng와 이름, 층, 최대 층수를 순서대로 입력한다.
  void addMarker(LatLng latLng, String name, int floors_l, int floors_h) {
    _LatLang.add(latLng);
    _buildingName.add(name);
    _floors_low.add(floors_l);
    _floors_height.add(floors_h);
  }

  void input_building_data(){
    addMarker(LatLng(35.859171, 128.487625), "공대1호관", -1,4);
    addMarker(LatLng(35.859300, 128.486937), "공대2호관", -1,5);
    addMarker(LatLng(35.859820, 128.487069), "공대3호관", -1,5);
    addMarker(LatLng(35.859679, 128.487733), "공대4호관", -1,5);
    addMarker(LatLng(35.857993, 128.488896), "오산관", -1,2);
    addMarker(LatLng(35.857432, 128.489328), "쉐턱관", -1,4);
    addMarker(LatLng(35.856479, 128.487114), "동산도서관", 0,7);
    addMarker(LatLng(35.856725, 128.489863), "행소박물관", -1,2);
    addMarker(LatLng(35.855549, 128.487740), "전산교육원", -1,2);
    addMarker(LatLng(35.855308, 128.485636), "봉경관", 0,4);
  }


  List<LatLng> get_latlang() => _LatLang;
  List<String> get_buildingName() => _buildingName;

  //빌딩이름을 받으면 해당 좌표로 반환
  LatLng building_change_latlang(String build) => _LatLang[_buildingName.indexOf(build)];




  List<String> make_building(String box)
  {
    List<String> building = <String>[];
    int a = _buildingName.indexOf(box);
    int low = _floors_low[a];
    int height = _floors_height[a];

    for(int i = low;i<=height;i++)
      {
        if(i == 0)
          continue;
        else if(i<0)
          building.add("F$i");
        else
          building.add("$i층");
      }
    return building;
  }

}

