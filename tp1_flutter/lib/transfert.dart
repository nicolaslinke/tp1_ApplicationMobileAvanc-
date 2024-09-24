import 'dart:ffi';

import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'transfert.g.dart';

@JsonSerializable()
class SignupRequest {
  SignupRequest();

  String username = '';
  String password = '';

  factory SignupRequest.fromJson(Map<String, dynamic> json) =>
      _$SignupRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SignupRequestToJson(this);
}

@JsonSerializable()
class SignupResponse {
  SignupResponse();

  String username = '';

  factory SignupResponse.fromJson(Map<String, dynamic> json) =>
      _$SignupResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignupResponseToJson(this);
}

@JsonSerializable()
class SigninRequest {
  SigninRequest();

  String username = '';
  String password = '';

  factory SigninRequest.fromJson(Map<String, dynamic> json) =>
      _$SigninRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SigninRequestToJson(this);
}

@JsonSerializable()
class SigninResponse {
  SigninResponse();

  String username = '';

  factory SigninResponse.fromJson(Map<String, dynamic> json) =>
      _$SigninResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SigninResponseToJson(this);
}


@JsonSerializable()
class AddTaskRequest {
  AddTaskRequest();

  String name = '';
  DateTime deadline = DateTime.now();

  factory AddTaskRequest.fromJson(Map<String, dynamic> json) =>
      _$AddTaskRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddTaskRequestToJson(this);
}


final _dateFormatter = DateFormat("yyyy-MM-dd");

DateTime _fromJson(String date) => _dateFormatter.parse(date);

String _toJson(DateTime date) => _dateFormatter.format(date);

@JsonSerializable()
class GetTasksRequest {
  GetTasksRequest();

  factory GetTasksRequest.fromJson(Map<String, dynamic> json) =>
      _$GetTasksRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetTasksRequestToJson(this);
}


@JsonSerializable()
class GetTasksResponse {
  GetTasksResponse();

  int id = 0;
  String name = '';
  int percentageDone = 0;
  double percentageTimeSpent = 0 as double;
  DateTime deadline = DateTime.now();

  factory GetTasksResponse.fromJson(Map<String, dynamic> json) =>
      _$GetTasksResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetTasksResponseToJson(this);
}

@JsonSerializable()
class ChangePercRequest {
  ChangePercRequest();

  factory ChangePercRequest.fromJson(Map<String, dynamic> json) =>
      _$ChangePercRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePercRequestToJson(this);
}

@JsonSerializable()
class SignoutRequest {
  SignoutRequest();

  factory SignoutRequest.fromJson(Map<String, dynamic> json) =>
      _$SignoutRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SignoutRequestToJson(this);
}