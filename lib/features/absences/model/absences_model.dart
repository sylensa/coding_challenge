// To parse this JSON data, do
//
//     final AbsencesModel = AbsencesModelFromJson(jsonString);

import 'dart:convert';

import 'package:coding_challenge/core/helper/helper.dart';

AbsencesModel AbsencesModelFromJson(String str) => AbsencesModel.fromJson(json.decode(str));

String AbsencesModelToJson(AbsencesModel data) => json.encode(data.toJson());

class AbsencesModel {
  String? message;
  List<AbsencesPayload>? payload;

  AbsencesModel({
    this.message,
    this.payload,
  });

  factory AbsencesModel.fromJson(Map<String, dynamic> json) => AbsencesModel(
    message: json["message"],
    payload: json["payload"] == null ? [] : List<AbsencesPayload>.from(json["payload"]!.map((x) => AbsencesPayload.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "payload": payload == null ? [] : List<dynamic>.from(payload!.map((x) => x.toJson())),
  };
}

class AbsencesPayload {
  int? admitterId;
  String? admitterNote;
  String? confirmedAt;
  String? createdAt;
  int? crewId;
  String? endDate;
  int? id;
  String? memberNote;
  String? rejectedAt;
  String? startDate;
  String? type;
  int? userId;

  AbsencesPayload({
    this.admitterId,
    this.admitterNote,
    this.confirmedAt,
    this.createdAt,
    this.crewId,
    this.endDate,
    this.id,
    this.memberNote,
    this.rejectedAt,
    this.startDate,
    this.type,
    this.userId,
  });

  factory AbsencesPayload.fromJson(Map<String, dynamic> json) => AbsencesPayload(
    admitterId: json["admitterId"],
    admitterNote: json["admitterNote"],
    confirmedAt: json["confirmedAt"] == null ? "" : dateFormat(DateTime.parse(json["confirmedAt"])),
    createdAt: json["createdAt"] == null ? "" : dateFormat(DateTime.parse(json["createdAt"])),
    crewId: json["crewId"],
    endDate: json["endDate"] == null ? null : dateFormat(DateTime.parse(json["endDate"])),
    id: json["id"],
    memberNote: json["memberNote"],
    rejectedAt: json["rejectedAt"] == null ? "" : dateFormat(DateTime.parse(json["rejectedAt"])),
    startDate: json["startDate"] == null ? "" : dateFormat(DateTime.parse(json["startDate"])),
    type: json["type"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "admitterId": admitterId,
    "admitterNote": admitterNote,
    "confirmedAt": confirmedAt,
    "createdAt": createdAt,
    "crewId": crewId,
    "endDate": endDate,
    "id": id,
    "memberNote": memberNote,
    "rejectedAt": rejectedAt,
    "startDate": startDate,
    "type": type,
    "userId": userId,
  };
}


