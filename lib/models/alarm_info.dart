import 'dart:convert';

import 'package:flutter/cupertino.dart';

// class AlarmInfo {
//   AlarmInfo(
//       this.id,
//     this.title,
//      this.alarmDateTime,
//      this.isPending,
//      this.gradientColorIndex,
//   );
//
//   final int id;
//   final String title;
//   final String alarmDateTime;
//   final String isPending;
//   final int gradientColorIndex;
//
//   factory AlarmInfo.fromRawJson(String str) => AlarmInfo.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//   factory AlarmInfo.fromMap(Map<String, dynamic> json) => AlarmInfo(
//     id: json["id"],
//     title: json["title"],
//     alarmDateTime: DateTime.parse(json["alarmDateTime"]),
//     isPending: json["isPending"],
//     gradientColorIndex: json["gradientColorIndex"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "title": title,
//     "alarmDateTime": alarmDateTime,
//     "isPending": isPending,
//     "gradientColorIndex": gradientColorIndex,
//   };
// }

// class AlarmInfo {
//   AlarmInfo({
//     this.id,
//     this.title,
//     this.alarmDateTime,
//     this.isPending,
//     this.gradientColorIndex,
//   });
//
//   final int? id;
//   final String? title;
//   final String? alarmDateTime;
//   final String? isPending;
//   final int? gradientColorIndex;
//
//   factory AlarmInfo.fromRawJson(String str) => AlarmInfo.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory AlarmInfo.fromJson(Map<String, dynamic> json) => AlarmInfo(
//     id: json["id"],
//     title: json["title"],
//     alarmDateTime: json["alarmDateTime"],
//     isPending: json["isPending"],
//     gradientColorIndex: json["gradientColorIndex"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "title": title,
//     "alarmDateTime": alarmDateTime,
//     "isPending": isPending,
//     "gradientColorIndex": gradientColorIndex,
//   };
// }

class AlarmInfo {
  AlarmInfo({
    this.id,
    this.title,
    this.alarmDateTime,
    this.isPending,
    this.gradientColorIndex,
  });

  int? id;
  String? title;
  String? alarmDateTime;
  String? isPending;
  int? gradientColorIndex;

  factory AlarmInfo.fromJson(String str) => AlarmInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AlarmInfo.fromMap(Map<String, dynamic> json) => AlarmInfo(
    id: json["id"],
    title: json["title"],
    alarmDateTime: json["alarmDateTime"],
    isPending: json["isPending"],
    gradientColorIndex: json["gradientColorIndex"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "alarmDateTime": alarmDateTime,
    "isPending": isPending,
    "gradientColorIndex": gradientColorIndex,
  };
}
