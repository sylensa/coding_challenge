// To parse this JSON data, do
//
//     final AbsencesModel = AbsencesModelFromJson(jsonString);

import 'dart:convert';

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
  DateTime? confirmedAt;
  DateTime? createdAt;
  int? crewId;
  DateTime? endDate;
  int? id;
  String? memberNote;
  DateTime? rejectedAt;
  DateTime? startDate;
  Type? type;
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
    confirmedAt: json["confirmedAt"] == null ? null : DateTime.parse(json["confirmedAt"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    crewId: json["crewId"],
    endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
    id: json["id"],
    memberNote: json["memberNote"],
    rejectedAt: json["rejectedAt"] == null ? null : DateTime.parse(json["rejectedAt"]),
    startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
    type: typeValues.map[json["type"]]!,
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "admitterId": admitterId,
    "admitterNote": admitterNote,
    "confirmedAt": confirmedAt?.toIso8601String(),
    "createdAt": createdAt?.toIso8601String(),
    "crewId": crewId,
    "endDate": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
    "id": id,
    "memberNote": memberNote,
    "rejectedAt": rejectedAt?.toIso8601String(),
    "startDate": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
    "type": typeValues.reverse[type],
    "userId": userId,
  };
}

enum Type {
  SICKNESS,
  VACATION
}

final typeValues = EnumValues({
  "sickness": Type.SICKNESS,
  "vacation": Type.VACATION
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
