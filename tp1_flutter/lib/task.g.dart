// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      name: json['name'] as String,
      creationDate: DateTime.parse(json['creationDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      percCompletion: (json['percCompletion'] as num).toInt(),
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'name': instance.name,
      'creationDate': instance.creationDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'percCompletion': instance.percCompletion,
    };
