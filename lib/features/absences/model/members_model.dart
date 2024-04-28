// To parse this JSON data, do
//
//     final membersModel = membersModelFromJson(jsonString);

import 'dart:convert';

MembersModel membersModelFromJson(String str) => MembersModel.fromJson(json.decode(str));

String membersModelToJson(MembersModel data) => json.encode(data.toJson());

class MembersModel {
  String? message;
  List<MembersPayload>? membersPayload;

  MembersModel({
    this.message,
    this.membersPayload,
  });

  factory MembersModel.fromJson(Map<String, dynamic> json) => MembersModel(
    message: json["message"],
    membersPayload: json["payload"] == null ? [] : List<MembersPayload>.from(json["payload"]!.map((x) => MembersPayload.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "MembersPayload": membersPayload == null ? [] : List<dynamic>.from(membersPayload!.map((x) => x.toJson())),
  };
}

class MembersPayload {
  int? crewId;
  int? id;
  String? image;
  String? name;
  int? userId;

  MembersPayload({
    this.crewId,
    this.id,
    this.image,
    this.name,
    this.userId,
  });

  factory MembersPayload.fromJson(Map<String, dynamic> json) => MembersPayload(
    crewId: json["crewId"],
    id: json["id"],
    image: json["image"],
    name: json["name"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "crewId": crewId,
    "id": id,
    "image": image,
    "name": name,
    "userId": userId,
  };
}
