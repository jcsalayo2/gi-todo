// To parse this JSON data, do
//
//     final checklistModel = checklistModelFromJson(jsonString);

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

ChecklistModel checklistModelFromJson(String str) =>
    ChecklistModel.fromJson(json.decode(str));

String checklistModelToJson(ChecklistModel data) => json.encode(data.toJson());

class ChecklistModel {
  DateTime date;
  bool isDone;
  String task;

  ChecklistModel({
    required this.date,
    required this.isDone,
    required this.task,
  });

  factory ChecklistModel.fromJson(Map<String, dynamic> json) => ChecklistModel(
        date: (json["date"] as Timestamp).toDate(),
        isDone: json["isDone"],
        task: json["task"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "isDone": isDone,
        "task": task,
      };
}
