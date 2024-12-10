import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable()
class Task {
  String name;
  DateTime creationDate;
  DateTime endDate;
  int percCompletion;

  Task({required this.name, required this.creationDate, required this.endDate, required this.percCompletion});

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
  Map<String, dynamic> toJson() => _$TaskToJson(this);
}