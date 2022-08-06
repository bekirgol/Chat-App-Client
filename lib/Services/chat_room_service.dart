import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:socketio_example/Constand/app_constand.dart';
import 'package:socketio_example/Models/chat_room_model.dart';

class ChatRoomService {
  Future<ChatRoom> addChatRoom() async {
    Uri url = Uri.parse("${AppConstand.BASE_URL}/rooms");

    final response = await http.post(url);

    if (response.statusCode == HttpStatus.ok) {
      return singleChatRoomFromJson(response.body);
    }

    throw response.body;
  }

  Future<List<ChatRoom>> getChatRoom(String id) async {
    Uri url = Uri.parse("${AppConstand.BASE_URL}/rooms/$id");

    final response = await http.get(url);
    if (response.statusCode == HttpStatus.ok) {
      return chatRoomFromJson(response.body);
    }
    throw response.body;
  }

  Future<String> isRoom(String user1, String user2) async {
    Uri url = Uri.parse("${AppConstand.BASE_URL}/rooms/is-room");
    final response = await http.post(url, body: {
      "user1": user1,
      "user2": user2,
    });

    if (response.statusCode == HttpStatus.ok) {
      return response.body;
    }
    return response.body;
  }

  Future<ChatRoom> getChatRoomById(String id) async {
    Uri url = Uri.parse("${AppConstand.BASE_URL}/rooms/by-id/$id");

    final response = await http.get(url);

    if (response.statusCode == HttpStatus.ok) {
      return singleChatRoomFromJson(response.body);
    }
    throw response.body;
  }

  Future<String> addUser(String userId, String roomId) async {
    Uri url = Uri.parse("${AppConstand.BASE_URL}/rooms/add-user");
    final response = await http.post(url, body: {
      "userId": userId,
      "roomId": roomId,
    });

    if (response.statusCode == HttpStatus.ok) {
      return response.body;
    }
    throw response.body;
  }
}
