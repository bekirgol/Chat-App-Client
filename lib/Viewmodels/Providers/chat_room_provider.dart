import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socketio_example/Models/chat_room_model.dart';
import 'package:socketio_example/Models/user_model.dart';
import 'package:socketio_example/Services/chat_room_service.dart';
import 'package:socketio_example/Services/user_service.dart';

class ChatRoomProvider with ChangeNotifier {
  List<ChatRoom> rooms = [];
  List<User>? users = [];
  ChatRoom? room;
  String? roomMessage;
  // List<ChatRoom> get rooms => _rooms;
  // set rooms(List<ChatRoom> value) {
  //   // _rooms = value;
  //   _rooms = value;
  //   notifyListeners();
  // }

  late ChatRoomService chatRoomService;
  late UserService userService;
  bool isLoading = false;
  User? user;
  late SharedPreferences prefs;

  ChatRoomProvider() {
    chatRoomService = ChatRoomService();
    userService = UserService();
    fetchRoom();
    fetchAllUser();
    initializeSharedPreference();
  }

  void changeLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  Future<void> initializeSharedPreference() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> fetchRoom() async {
    try {
      changeLoading();
      rooms = await chatRoomService.getChatRoom("62bf7ec54f24abfa8cdb3d5e");
      notifyListeners();
      changeLoading();
    } catch (e) {
      print(e);
      changeLoading();
    }
  }

  Future<ChatRoom> AddChatRoom() async {
    try {
      changeLoading();
      room = await chatRoomService.addChatRoom();
      changeLoading();
      return room!;
    } catch (e) {
      changeLoading();
      print(e);
      notifyListeners();

      throw e;
    }
  }

  Future<String> isChatRoom(String user1, String user2) async {
    try {
      changeLoading();
      roomMessage = await chatRoomService.isRoom(user1, user2);
      changeLoading();
      return roomMessage!;
    } catch (e) {
      changeLoading();
      print(e);
      throw e;
    }
  }

  Future<void> fetchUserById(String id) async {
    try {
      user = await userService.getUserById(id);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchAllUser() async {
    try {
      changeLoading();
      users = await userService.getAllUser();
      users = users
          ?.where((user) => user.id != prefs.getString("currentUser"))
          .toList();
      notifyListeners();
    } catch (e) {
      print(e);
      isLoading = false;
      notifyListeners();

      throw e;
    }
  }

  Future<void> addUser(String userId, String roomId) async {
    try {
      changeLoading();
      chatRoomService.addUser(userId, roomId);
      changeLoading();
    } catch (e) {
      changeLoading();
      print(e);
      throw e;
    }
  }

  Future<ChatRoom> fetchChatRoomById(String roomId) async {
    try {
      changeLoading();
      room = await chatRoomService.getChatRoomById(roomId);
      changeLoading();
      return room!;
    } catch (e) {
      changeLoading();
      print(e);
      throw e;
    }
  }
}
