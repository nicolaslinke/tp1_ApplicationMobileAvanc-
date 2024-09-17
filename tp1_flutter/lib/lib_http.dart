import 'package:dio/dio.dart';
//import 'package:post_json_error/transfert.dart';
import 'package:tp1_flutter/transfert.dart';

Future<SignupResponse> signup(SignupRequest req) async {
  try {
    var response = await Dio()
        .post('http://10.0.2.2:8787/api/id/signup', data: req);
    print(response);
    return SignupResponse.fromJson(response.data);
  } catch (e) {
    print(e);
    rethrow;
  }
}


Future<SigninResponse> signin(SigninRequest req) async {
  try {
    var response = await Dio()
        .post('http://10.0.2.2:8787/api/id/signin', data: req);
    print(response);
    return SigninResponse.fromJson(response.data);
  } catch (e) {
    print(e);
    rethrow;
  }
}