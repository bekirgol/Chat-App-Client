import 'dart:convert';

List<Message> messageFromJson(String response) =>
    List<Message>.from(json.decode(response).map((x) => Message.fromJson(x)));

String messageToJson(Message message) => json.encode(message.toJson());

class Message {
  final String? id;
  final String? message;
  final String? senderId;
  final String? receiverId;
  final String? roomId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Message({
    this.id,
    this.roomId,
    this.message,
    this.senderId,
    this.receiverId,
    this.createdAt,
    this.updatedAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["_id"],
        message: json["message"],
        senderId: json["senderId"],
        receiverId: json["receiverId"],
        roomId: json["roomId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "senderId": senderId,
        "receiverId": receiverId,
        "roomId": roomId
      };
}
