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
  String id;
  DateTime date;
  bool isDone;
  String task;
  DateTime dateTimeAdded;

  ChecklistModel({
    required this.id,
    required this.date,
    required this.isDone,
    required this.task,
    required this.dateTimeAdded,
  });

  factory ChecklistModel.fromJson(Map<String, dynamic> json) => ChecklistModel(
        id: json["id"],
        date: (json["date"] as Timestamp).toDate(),
        isDone: json["isDone"],
        task: json["task"],
        dateTimeAdded: json["dateTimeAdded"].toDate(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "isDone": isDone,
        "task": task,
        "dateTimeAdded": dateTimeAdded,
      };
}
