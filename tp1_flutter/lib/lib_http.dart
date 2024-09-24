import 'package:dio/dio.dart';
//import 'package:post_json_error/transfert.dart';
import 'package:tp1_flutter/transfert.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';

class SingletonDio {
  static var cookiemanager = CookieManager(CookieJar());

  static Dio getDio() {
    Dio dio = Dio();
    dio.interceptors.add(cookiemanager);
    return dio;
  }

}

Future<SignupResponse> signup(SignupRequest req) async {
  try {
    var response = await  SingletonDio.getDio()
        .post('http://10.0.2.2:8787/api/id/signup', data: req.toJson());
    print(response);
    return SignupResponse.fromJson(response.data);
  } catch (e) {
    print(e);
    rethrow;
  }
}


Future<SigninResponse> signin(SigninRequest req) async {
  try {
    var response = await SingletonDio.getDio()
        .post('http://10.0.2.2:8787/api/id/signin', data: req.toJson());
    print(response);
    return SigninResponse.fromJson(response.data);
  } catch (e) {
    print(e);
    rethrow;
  }
}


Future<SigninResponse> perc(int taskID, int value) async {
  try {
    var response = await SingletonDio.getDio()
        .get('http://10.0.2.2:8787/api/progress/' + taskID.toString() + '/' + value.toString());
    print(response);
    return SigninResponse.fromJson(response.data);
  } catch (e) {
    print(e);
    rethrow;
  }
}

Future<String> addTask(AddTaskRequest req) async {
  try {
    var response = await SingletonDio.getDio()
        .post('http://10.0.2.2:8787/api/add');
    print(response);
    return "ok";
  } catch (e) {
    print(e);
    rethrow;
  }
}

Future<List<GetTasksResponse>> getTasks() async {
  try {
    var response = await SingletonDio.getDio()
        .get('http://10.0.2.2:8787/api/home');
    print(response);
    var listJSON = response.data as List;
    var listTask = listJSON.map((elementJSON) {
      return GetTasksResponse.fromJson(elementJSON);
    }).toList();
    return listTask;
  } catch (e) {
    print(e);
    rethrow;
  }
}