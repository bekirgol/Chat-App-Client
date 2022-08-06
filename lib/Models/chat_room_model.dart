import 'dart:convert';

List<ChatRoom> chatRoomFromJson(String response) =>
    List<ChatRoom>.from(json.decode(response).map((x) => ChatRoom.fromJson(x)));

ChatRoom singleChatRoomFromJson(String response) =>
    ChatRoom.fromJson(json.decode(response));

class ChatRoom {
  final String? id;
  List<String>? users;
  final DateTime? updatedAt;
  final DateTime? createdAt;

  ChatRoom({
    this.id,
    this.users,
    this.updatedAt,
    this.createdAt,
  });

  factory ChatRoom.fromJson(Map<String, dynamic> json) => ChatRoom(
        id: json["_id"],
        users: List<String>.from(json["users"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );
}
