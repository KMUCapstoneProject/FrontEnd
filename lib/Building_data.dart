import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:custom_info_window/custom_info_window.dart';

class building_data {
  CustomInfoWindowController _customInfoWindowController =
  CustomInfoWindowController();
  final List<Marker> _markers = <Marker>[];
  final List<LatLng> _LatLang = <LatLng>[
    LatLng(35.855764, 128.487199), // 계명대학교
    LatLng(35.859171, 128.487625), // 공대1호관
    LatLng(35.859300, 128.486937), // 공대2호관
    LatLng(35.859820, 128.487069), // 공대3호관
    LatLng(35.859679, 128.487733), // 공대4호관
    LatLng(35.857993, 128.488896), // 오산관
    LatLng(35.857432, 128.489328), // 쉐턱관
    LatLng(35.856479, 128.487114), // 동산도서관
    LatLng(35.856725, 128.489863), // 행소박물관
    LatLng(35.855549, 128.487740), // 전산교육원
  ];
  final List<String> _buildingName = <String>[
    "계명대학교",
    "공대1호관",
    "공대2호관",
    "공대3호관",
    "공대4호관",
    "오산관",
    "쉐턱관",
    "동산도서관",
    "행소박물관",
    "전산교육원",
  ];

  List<Marker> input_marker() {
    return _markers;
  }

  List<LatLng> input_latlang() {
    return _LatLang;
  }

  List<String> input_buildingName() {
    return _buildingName;
  }
}

