import 'dart:io';

import 'package:socketio_example/Constand/app_constand.dart';
import 'package:socketio_example/Models/message_model.dart';
import 'package:http/http.dart' as http;

class MessageService {
  Future<List<Message>> getMessages(String roomId) async {
    Uri url = Uri.parse("${AppConstand.BASE_URL}/messages/$roomId");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return messageFromJson(response.body);
    }

    throw response.body;
  }

  Future<String> addMessage(Message message) async {
    Uri url = Uri.parse("${AppConstand.BASE_URL}/messages");
    final response = await http.post(
      url,
      body: messageToJson(message),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == HttpStatus.ok) {
      return response.body;
    }
    throw response.body;
  }
}
