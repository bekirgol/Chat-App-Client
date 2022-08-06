import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socketio_example/Constand/app_constand.dart';
import 'package:socketio_example/Models/chat_room_model.dart';
import 'package:socketio_example/Models/message_model.dart';
import 'package:socketio_example/Services/message_service.dart';

class MessageProvider with ChangeNotifier {
  late TextEditingController messageController;
  late IO.Socket socket;
  late MessageService messageService;
  List<Message> messages = [];
  // List<String> list = [];
  late SharedPreferences prefs;
  // List<String> get list => _list;
  // set list(List<String> value) {
  //   _list = value;
  //   notifyListeners();
  // }

  MessageProvider() {
    messageController = TextEditingController();
    messageService = MessageService();
    connect();
    initializeSharedPreference();
  }

  initializeSharedPreference() async {
    prefs = await SharedPreferences.getInstance();
  }

  void connect() {
    socket = IO.io("${AppConstand.BASE_URL}", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    socket.on("odayaGir", (data) {
      print(data);
    });

    socket.emit("chat-screen", "mesaj görüldü");

    socket.onConnect((data) => print("Connected"));
    socket.onDisconnect((data) => print("Disconnected"));
    socket.on("event", (data) => print(data));
  }

  void sendMessage() {
    socket.emit("sendMessage", messageController.text);
    socket.on(
      "message",
      (data) {
        notifyListeners();
      },
    );
  }

  Future<List<Message>> fetchMessage(String roomId) async {
    try {
      messages = await messageService.getMessages(roomId);
      return messages;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> addMessage(Message message) async {
    try {
      messageService.addMessage(message);
    } catch (e) {}
  }
}
