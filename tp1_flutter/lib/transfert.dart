import 'dart:ffi';

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
  String deadline = '';

  factory AddTaskRequest.fromJson(Map<String, dynamic> json) =>
      _$AddTaskRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddTaskRequestToJson(this);
}


@JsonSerializable()
class GetTasksRequest {
  GetTasksRequest();

  factory GetTasksRequest.fromJson(Map<String, dynamic> json) =>
      _$GetTasksRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetTasksRequestToJson(this);
}


/*@JsonSerializable()
class GetTasksResponse {
  GetTasksResponse();

  Long id = 0 as Long;
  String name = '';
  int percentageDone = 0;
  double percentageTimeSpent = 0 as double;
  Date deadline = '';

  factory GetTasksResponse.fromJson(Map<String, dynamic> json) =>
      _$GetTasksResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetTasksResponseToJson(this);
}*/

@JsonSerializable()
class ChangePercRequest {
  ChangePercRequest();

  int id = 1;
  int valeur = 1;

  factory ChangePercRequest.fromJson(Map<String, dynamic> json) =>
      _$ChangePercRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePercRequestToJson(this);
}

@JsonSerializable()
class ChangePercResponse {
  ChangePercResponse();

  int id = 1;
  int valeur = 1;

  factory ChangePercResponse.fromJson(Map<String, dynamic> json) =>
      _$ChangePercResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePercResponseToJson(this);
}

@JsonSerializable()
class SignoutRequest {
  SignoutRequest();

  factory SignoutRequest.fromJson(Map<String, dynamic> json) =>
      _$SignoutRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SignoutRequestToJson(this);
}