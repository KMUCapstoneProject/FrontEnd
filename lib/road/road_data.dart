//import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_2/Building_map/Building_data.dart';
import 'package:project_2/Server_conn/mariaDB_server.dart';

import '../Server_conn/neo4j_server.dart';

class road_data {
  final List<Polyline> _road_line = <Polyline>[];
  final List<Polyline> _road_line_a = <Polyline>[];
  final List<Circle> _circles = <Circle>[];
  final List<LatLng> test_test = <LatLng>[];
  LatLng _now_location = LatLng(0.0, 0.0);

  List<LatLng> _load = [];
  List<LatLng> _load_a = [];
  Work _load_work = Work();


  static final road_data _instance = road_data._internal();

  factory road_data() {
    return _instance;
  }

  road_data._internal() {}

  void input_road(String building_start, String building_end) async {
    LatLng data_start;
    LatLng data_end;

    if (building_start == "현재위치") {
      //서버에 현재 위치 넣어주기
      data_start = _now_location;
      data_end = building_data().building_change_latlang(building_end);
      final latlng = await mariaDB_server().curr_load_search(_now_location, building_end);
      final latlng_a = await mariaDB_server().curr_load_search_a(_now_location, building_end);
      _load = _load_work.work_load(latlng.toString());
      _load_a = _load_work.work_load(latlng_a.toString());
      _load.insert(0, data_start);
      _load_a.insert(0, data_start);
    } else {
      data_start = building_data().building_change_latlang(building_start);
      data_end = building_data().building_change_latlang(building_end);
      final latlng = await mariaDB_server().building_load_search(building_start, building_end);
      final latlng_a = await mariaDB_server().building_load_search_a(building_start, building_end);
      _load = _load_work.work_load(latlng.toString());
      _load_a = _load_work.work_load(latlng_a.toString());
    }
    test_test.add(data_end);
    _circles.add(
      Circle(
        circleId: CircleId("circle_1"),
        center: data_end,
        radius: 20,
        fillColor: Colors.blue.withOpacity(0.3),
        strokeWidth: 2,
        strokeColor: Colors.blue,
      ),
    );
    _road_line.add(
      Polyline(
        polylineId: PolylineId("test"),
        points: _load,
        width: 3,
        color: Colors.blue,
      ),
    );
    _road_line_a.add(
      Polyline(
        polylineId: PolylineId("test"),
        points: _load_a,
        width: 3,
        color: Colors.blue,
      ),
    );
  }

  List<Polyline> get_line_a() => _road_line_a;

  List<Polyline> get_line() => _road_line;

  List<Circle> get_circles() => _circles;

  List<LatLng> get_latlng() => test_test;

  void reset_road() {
    _road_line_a.clear();
    _road_line.clear();
    _circles.clear();
    test_test.clear();
  }

  void input_now_location(double lat, double log) {
    _now_location = LatLng(lat, log);
  }

  LatLng get_now_test() => _now_location;
}
