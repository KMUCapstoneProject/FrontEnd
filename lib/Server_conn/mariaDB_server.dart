import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:project_2/user_data.dart';

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
      //print("${response.data}");
      //print("${response.data["nickname"].toString()}");
      //print("${response.data["email"].toString()}");
      //print("${response.data["roles"].toString()}");
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
  Future<void> event_registration_input(int category,String title, String content,String start,String end, double lat, double log,String details) async {

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
  Future<void> find_room(String building_name) async {
    try {
      Response response =
      await dio!.get("${this.url}api/timetable/findRoominBuilding?building=공1");
      if (response.statusCode == 200) {
        print('Success: ${response.data}');
      }
      print("object");
    } catch (e) {
      if (e is DioException) {
        print('Bad Request: ${e.response!.data}');
      }
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
      "receiverName" :  receiverName,
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
      await dio!.get("${this.url}messages/sent");
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

  Future<void> room(String name) async {
    String apiJoin = "공1";
    String jsonApiJoin = jsonEncode(apiJoin);

    try {
      Response response =
      await dio!.get("${this.url}api/timetable/findClassinBuilding",data: jsonApiJoin );
      if (response.statusCode == 200||response.statusCode == 201) {
        print(response.data["data"]);
      }
    } catch (e) {
      if (e is DioException) {
        print('Bad Request: ${e.response!.data}');
      }
    }
  }



/*
 Future<void> fetchData() async {
    try {
      // 예를 들어, 로그인 후 데이터를 가져올 때
      final getDataResponse = await dio.get("https://example.com/api/data");

      print("Data Response: ${getDataResponse.data}");
    } catch (e) {
      print("Fetch data error: $e");
    }
  }

  Future<void> login_true(String username, String password) async {
    String uri = "https://dbp.kdedevelop.com/api/login";
    String uri_g = "https://dbp.kdedevelop.com/";
    final formData = FormData.fromMap({
      'account': 'E00012',
      'password': 'password',
    });

    final response = await dio.post(
        uri,
        data: formData
    );

    List<Cookie> results = await cookieJar.loadForRequest(Uri.parse('https://dbp.kdedevelop.com/'));
    print(results);

    print("LOGIN CODE : ${response.statusCode}");

    print("READY");

    String infoUri = "https://dbp.kdedevelop.com/api/employee";
    final infoResponse = await dio.get(
        infoUri
    );

    print("Code : " + infoResponse.statusCode.toString());
    print("RESPONSE DATA : ${infoResponse.data}");
  }*/
}
