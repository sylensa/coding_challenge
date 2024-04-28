// To parse this JSON data, do
//
//     final membersModel = membersModelFromJson(jsonString);

import 'dart:convert';

MembersModel membersModelFromJson(String str) => MembersModel.fromJson(json.decode(str));

String membersModelToJson(MembersModel data) => json.encode(data.toJson());

class MembersModel {
  String? message;
  List<Payload>? payload;

  MembersModel({
    this.message,
    this.payload,
  });

  factory MembersModel.fromJson(Map<String, dynamic> json) => MembersModel(
    message: json["message"],
    payload: json["payload"] == null ? [] : List<Payload>.from(json["payload"]!.map((x) => Payload.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "payload": payload == null ? [] : List<dynamic>.from(payload!.map((x) => x.toJson())),
  };
}

class Payload {
  int? crewId;
  int? id;
  String? image;
  String? name;
  int? userId;

  Payload({
    this.crewId,
    this.id,
    this.image,
    this.name,
    this.userId,
  });

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
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
