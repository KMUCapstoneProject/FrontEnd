import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_2/Server_conn/neo4j_server.dart';
import 'package:project_2/user_data.dart';
import 'package:http_parser/http_parser.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class mariaDB_server {
  static final mariaDB_server _instance = mariaDB_server._internal();
  late Dio dio;
  late CookieJar cookieJar;
  final String url = "https://friedkimchi.kdedevelop.com/";

  factory mariaDB_server() {
    return _instance;
  }

  mariaDB_server._internal() {
    dio = Dio();
    cookieJar = CookieJar();
    dio.options.followRedirects = true;
    dio.options.maxRedirects = 10;
    dio.options.validateStatus =
        (status) => (status != null) && (status >= 200 && status <= 310);
    dio.interceptors.add(CookieManager(cookieJar));
  }


  //로그인
  Future<Map<String,dynamic>> login(String email, String password) async {
    final formData = FormData.fromMap({
      'email': email,
      'password': password,
    });

    cookieJar.deleteAll();
    try {
      Response response =
          await dio!.post("${this.url}api/login", data: formData);
    } catch (e) {
      if (e is DioException) {
        print('Bad Request: ${e.response!.data}');
        return {};
      }
    }
    try {
      Response response =
      await dio!.get("${this.url}api/info");
      return response.data;
    } catch (e) {
      return {};
    }
  }

  //로그아웃
  Future<void> logout() async {
    try {
      Response response =
      await dio!.get("${this.url}api/logout");
    } catch (e) {
      if (e is DioException) {
        print('Bad Request: ${e.response!.data}');
      }
    }
    cookieJar.deleteAll();
    user_data().reset_login_data();
  }

  //회원가입
  Future<void> create_member(String email, String nickname, String password) async {
    String url_member = this.url + "api/join";

    Map<String, String> apiJoin = {
      'nickname': nickname,
      'email': email,
      'password': password
    };
    String jsonApiJoin = jsonEncode(apiJoin);

    try {
      Response response =
          await dio!.post("${this.url}api/join", data: jsonApiJoin);
      if (response.statusCode == 201) {
        print('Success: ${response.data}');
      }
    } catch (e) {
      if (e is DioException) {
        print('Bad Request: ${e.response!.data}');
      }
    }
  }

  //비교과 및 행사 신청서 보내기
  Future<void> event_registration_input(int category,String title, String content,String start,String end, double lat, double log,String details,List<XFile> image) async {

    Map<String, dynamic> apiJoin = {
      "categoryId" :  category,
      "title" : title,
      "content" : content,
      "startTime" : start,
      "deadline" : end,
      "latitude" : lat,
      "longitude" : log,
      "details" : details
    };

    String jsonApiJoin = jsonEncode(apiJoin);
    try {
      Response response =
          await dio!.post("${this.url}api/posting/add", data: jsonApiJoin);
      if (response.statusCode == 201) {
        print('Success: ${response.data}');
      }
    } catch (e) {
      if (e is DioException) {
        print('Bad Request: ${e.response!.data}');
      }
    }

    image_input(image);
  }

  //신청완료 행사 받기
  Future<List<dynamic>> event_registration_get1() async {
    try {
      Response response =
      await dio!.get("${this.url}api/posting/list?categoryId=1");
      if (response.statusCode == 200) {
        print('Success: ${response.data}');
        return response.data;
      }
    } catch (e) {
      if (e is DioException) {
        print('Bad Request: ${e.response!.data}');
      }
    }
    return <dynamic>[];
  }

  //신청완료 비교과 받기
  Future<List<dynamic>> event_registration_get2() async {
    try {
      Response response =
      await dio!.get("${this.url}api/posting/list?categoryId=2");
      if (response.statusCode == 200) {
        print('Success: ${response.data}');
        return response.data;
      }
    } catch (e) {
      if (e is DioException) {
        print('Bad Request: ${e.response!.data}');
      }
    }
    return <dynamic>[];
  }

  //빈 강의실 정보 받기
  Future<List<dynamic>> find_room(String building_name) async {
    try {
      Response response =
      await dio!.get("${this.url}api/timetable/findClassinBuilding?building=$building_name");
      List<dynamic> test = response.data;
      test.sort((a, b) => a['classNum']!.compareTo(b['classNum']!));
      return test;
    } catch (e) {
      if (e is DioException) {
        print('Bad Request: ${e.response!.data}');
      }
      return <dynamic>[];
    }
  }

  //비교과 신청 완료 안된 내용
  Future<List<dynamic>> event_list() async {
    try {
      Response response =
      await dio!.get("${this.url}admin/posting/list/waiting0");
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      if (e is DioException) {
        print('Bad Request: ${e.response!.data}');
      }
    }
    return <dynamic>[];
  }

  //게시물 삭제
  Future<void> event_list_delete(int postId) async {
    try {
      Response response =
      await dio!.get("${this.url}api/posting/delete?postId=$postId");
      if (response.statusCode == 200) {
        print(response.data);
      }
    } catch (e) {
      if (e is DioException) {
        print('Bad Request: ${e.response!.data}');
      }
    }
  }

  //게시물 수락
  Future<void> event_list_upgrade(int postId) async {
    try {
      Response response =
      await dio!.get("${this.url}admin/posting/updatestatus?postId=$postId");
      if (response.statusCode == 200) {
        print(response.data);
      }
    } catch (e) {
      if (e is DioException) {
        print('Bad Request: ${e.response!.data}');
      }
    }
  }

  //메세지 보내기
  Future<bool> messges_input(String title,String content,String receiverName) async {
    Map<String, dynamic> apiJoin = {
      "title" : title,
      "content" : content,
      "receiverName" :  "admin@naver.com",
    };
    String jsonApiJoin = jsonEncode(apiJoin);

    try {
      Response response =
      await dio!.post("${this.url}messages",data: jsonApiJoin);
      if (response.statusCode == 201) {
        print(response.data);
      }
      return true;
    } catch (e) {
      if (e is DioException) {
        print('Bad Request: ${e.response!.data}');
      }
      return false;
    }
  }

  //메세지 받기
  Future<List<dynamic>> messges_output() async {

    try {
      Response response =
      await dio!.get("${this.url}messages/received");
      if (response.statusCode == 200||response.statusCode == 201) {
        print(response.data["data"]);
      }
      return response.data["data"];
    } catch (e) {
      if (e is DioException) {
        print('Bad Request: ${e.response!.data}');
      }
      return <dynamic>[];
    }
  }

  //image 디비 넣기
  Future<void> image_input(List<XFile> image) async {
    List<XFile> _pickedImgs = image;
    final List<MultipartFile> _files = _pickedImgs.map((img) => MultipartFile.fromFileSync(img.path,  contentType: new MediaType("image", "png"))).toList();

    final formData = FormData.fromMap({
      'file': _files,
    });

    try {
      Response response =
      await dio!.post("${this.url}uploadFile",data: formData);
    } catch (e) {
      if (e is DioException) {
        print('Bad Request: ${e.response!.data}');
      }
    }
  }

  Future<String> building_load_search(String start, String end) async {
    try {
      Response response =
      await dio!.get("${this.url}location/find?start_name=${start}&end_name=${end}");
      return response.data;
    } catch (e) {
      if (e is DioException) {
        print('Bad Request: ${e.response!.data}');
      }
      return "";
    }
  }

  Future<String> building_load_search_a(String start, String end) async {
    try {
      Response response =
      await dio!.get("${this.url}location/find_A?start_name=${start}&end_name=${end}");
      return response.data;
    } catch (e) {
      if (e is DioException) {
        print('Bad Request: ${e.response!.data}');
      }
      return "";
    }
  }

  Future<String> curr_load_search(LatLng start, String end) async {
    try {
      Response response =
      await dio!.get("${this.url}location/findMe?start_position=현재위치&start_pos_latitude=${start.latitude}&start_pos_longitude=${start.longitude}&end_name=${end}");
      return response.data;
    } catch (e) {
      if (e is DioException) {
        print('Bad Request: ${e.response!.data}');
      }
      return "";
    }
  }

  Future<String> curr_load_search_a(LatLng start, String end) async {
    try {
      Response response =
      await dio!.get("${this.url}location/findMe_A?start_position=현재위치&start_pos_latitude=${start.latitude}&start_pos_longitude=${start.longitude}&end_name=${end}");
      return response.data;
    } catch (e) {
      if (e is DioException) {
        print('Bad Request: ${e.response!.data}');
      }
      return "";
    }
  }


}
