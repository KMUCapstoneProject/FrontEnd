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

  Future<bool> login(String email, String password) async {
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
      }
    }

    try {
      Response response =
      await dio!.get("${this.url}api/info");
      print("${response.data}");
      print("${response.data["nickname"].toString()}");
      print("${response.data["email"].toString()}");
      print("${response.data["roles"].toString()}");


      user_data().input_login_data(response.data["nickname"].toString(), response.data["email"].toString(), response.data["roles"].toString());

      return true;
    } catch (e) {
      return false;
    }
  }

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

  Future<void> create_member(
      String email, String nickname, String password) async {
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
      print("object");
    } catch (e) {
      if (e is DioException) {
        print('Bad Request: ${e.response!.data}');
      }
    }
  }

  Future<void> event_registration_input(String title, String content,DateTime start,DateTime end,int a,int b, double lat, double log) async {
    print("$start  $end  ");
    Map<String, dynamic> apiJoin = {
      "categoryId" :  a,
      "title" : title,
      "content" : content,
      "startTime" : start,
      "deadline" : end,
      "latitude" : lat,
      "longitude" : log
    };

    String jsonApiJoin = jsonEncode(apiJoin);

    /*try {
      Response response =
          await dio!.post("${this.url}api/join", data: jsonApiJoin);
      if (response.statusCode == 201) {
        print('Success: ${response.data}');
      }
      print("object");
    } catch (e) {
      if (e is DioException) {
        print('Bad Request: ${e.response!.data}');
      }
    }*/
  }


  Future<void> event_registration_get(String a) async {

    try {
      Response response =
      await dio!.get("${this.url}api/posting/list?categoryId=0");
      if (response.statusCode == 201) {
        print('Success: ${response.data}');
      }
      print("object");
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
