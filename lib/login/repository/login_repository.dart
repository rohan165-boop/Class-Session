import 'package:dio/dio.dart';

class LoginRepo {
  LoginRepo._();
  static const String logInRoute = "https://dummyjson.com/auth/login";

  static Future<dynamic> login(
      {required String username, required String password}) async {
    final dio = Dio();
    dynamic data;

    var resp = await dio.post(
      logInRoute,
      data: {
        "username": username,
        "password": password,
      },
    );

    if (resp.statusCode == 200 || resp.statusCode == 201) {
      data = resp.data;
    }
    return data;
  }
}
