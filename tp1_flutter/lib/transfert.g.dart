// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupRequest _$SignupRequestFromJson(Map<String, dynamic> json) =>
    SignupRequest()
      ..username = json['username'] as String
      ..password = json['password'] as String;

Map<String, dynamic> _$SignupRequestToJson(SignupRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };

SignupResponse _$SignupResponseFromJson(Map<String, dynamic> json) =>
    SignupResponse()..username = json['username'] as String;

Map<String, dynamic> _$SignupResponseToJson(SignupResponse instance) =>
    <String, dynamic>{
      'username': instance.username,
    };

SigninRequest _$SigninRequestFromJson(Map<String, dynamic> json) =>
    SigninRequest()
      ..username = json['username'] as String
      ..password = json['password'] as String;

Map<String, dynamic> _$SigninRequestToJson(SigninRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };

SigninResponse _$SigninResponseFromJson(Map<String, dynamic> json) =>
    SigninResponse()..username = json['username'] as String;

Map<String, dynamic> _$SigninResponseToJson(SigninResponse instance) =>
    <String, dynamic>{
      'username': instance.username,
    };

AddTaskRequest _$AddTaskRequestFromJson(Map<String, dynamic> json) =>
    AddTaskRequest()
      ..name = json['name'] as String
      ..deadline = json['deadline'] as String;

Map<String, dynamic> _$AddTaskRequestToJson(AddTaskRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'deadline': instance.deadline,
    };

GetTasksRequest _$GetTasksRequestFromJson(Map<String, dynamic> json) =>
    GetTasksRequest();

Map<String, dynamic> _$GetTasksRequestToJson(GetTasksRequest instance) =>
    <String, dynamic>{};

ChangePercRequest _$ChangePercRequestFromJson(Map<String, dynamic> json) =>
    ChangePercRequest()
      ..id = (json['id'] as num).toInt()
      ..valeur = (json['valeur'] as num).toInt();

Map<String, dynamic> _$ChangePercRequestToJson(ChangePercRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'valeur': instance.valeur,
    };

ChangePercResponse _$ChangePercResponseFromJson(Map<String, dynamic> json) =>
    ChangePercResponse()
      ..id = (json['id'] as num).toInt()
      ..valeur = (json['valeur'] as num).toInt();

Map<String, dynamic> _$ChangePercResponseToJson(ChangePercResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'valeur': instance.valeur,
    };

SignoutRequest _$SignoutRequestFromJson(Map<String, dynamic> json) =>
    SignoutRequest();

Map<String, dynamic> _$SignoutRequestToJson(SignoutRequest instance) =>
    <String, dynamic>{};
