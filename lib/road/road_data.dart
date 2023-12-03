//import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_2/Building_map/Building_data.dart';

class road_data {
  final List<Polyline> _road_line = <Polyline>[];
  final List<Circle> _circles = <Circle>[];
  final List<LatLng> test_test = <LatLng>[];
  LatLng _now_location = LatLng(0.0, 0.0);

  static final road_data _instance = road_data._internal();

  factory road_data() {
    return _instance;
  }

  road_data._internal() {}

  void input_road(String building_start, String building_end) {
    LatLng data_start;
    LatLng data_end;
    if (building_start == "현재위치") {
      //서버에 현재 위치 넣어주기
      data_start = _now_location;
      data_end = building_data().building_change_latlang(building_end);
    } else {
      data_start = building_data().building_change_latlang(building_start);
      data_end = building_data().building_change_latlang(building_end);
    }
    test_test.add(data_end);
    /*if (_circles.isEmpty!) {
      reset_road();
    }*/
    _circles.add(
      Circle(
        circleId: CircleId("circle_1"),
        center: data_end,
        radius: 30,
        fillColor: Colors.blue.withOpacity(0.3),
        strokeWidth: 2,
        strokeColor: Colors.blue,
      ),
    );
    _road_line.add(
      Polyline(
        polylineId: PolylineId("test"),
        points: [
          data_start,
          data_end,
        ],
        width: 1,
        color: Colors.blue,
      ),
    );
  }

  void input_road2(String building) {
    LatLng data = building_data().building_change_latlang(building);
    test_test.add(data);
    /*if (_circles.isEmpty!) {
      reset_road();
    }*/
    _circles.add(
      Circle(
        circleId: CircleId("circle_1"),
        center: data,
        radius: 30,
        fillColor: Colors.blue.withOpacity(0.3),
        strokeWidth: 2,
        strokeColor: Colors.blue,
      ),
    );
    _road_line.add(
      Polyline(
        polylineId: PolylineId("test"),
        points: [
          LatLng(35.852855, 128.487020), ////////////test
          LatLng(35.854607, 128.487019),
          LatLng(35.854592, 128.486081),
          LatLng(35.855079, 128.486058),
          LatLng(35.855180, 128.485849),
          LatLng(35.855290, 128.485857),
          data,
        ],
        width: 1,
        color: Colors.blue,
      ),
    );
  }

  List<Polyline> get_line() => _road_line;

  List<Circle> get_circles() => _circles;

  List<LatLng> get_latlng() => test_test;

  void reset_road() {
    _road_line.clear();
    _circles.clear();
    test_test.clear();
  }

  void input_now_location(double lat, double log) {
    _now_location = LatLng(lat, log);
  }

  LatLng get_now_test() => _now_location;
}
