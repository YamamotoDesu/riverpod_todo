import 'dart:convert';

TaskModel taskFromJson(String str) => TaskModel.fromJson(json.decode(str));

String taskToJson(TaskModel data) => json.encode(data.toJson());

class TaskModel {
  int? id;
  String? title;
  String? desc;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? remind;
  String? repeat;

  TaskModel({
    this.id,
    this.title,
    this.desc,
    this.isCompleted,
    this.date,
    this.startTime,
    this.endTime,
    this.remind,
    this.repeat,
  });

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    desc = json['desc'];
    isCompleted = json['isCompleted'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    remind = json['remind'];
    repeat = json['repeat'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'desc': desc,
        'isCompleted': isCompleted,
        'date': date,
        'startTime': startTime,
        'endTime': endTime,
        'remind': remind,
        'repeat': repeat,
      };
}
