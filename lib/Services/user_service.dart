import 'dart:io';

import 'package:socketio_example/Constand/app_constand.dart';
import 'package:socketio_example/Models/user_model.dart';
import 'package:http/http.dart' as http;

class UserService {
  Future<User> getUserById(String id) async {
    Uri url = Uri.parse("${AppConstand.BASE_URL}/users/$id");
    final response = await http.get(url);

    if (response.statusCode == HttpStatus.ok) {
      return userFromJson(response.body);
    }
    throw response.body;
  }

  Future<User> login(String email, String password) async {
    Uri url = Uri.parse("${AppConstand.BASE_URL}/users/login");

    final response =
        await http.post(url, body: {"email": email, "password": password});

    if (response.statusCode == HttpStatus.ok) {
      return userFromJson(response.body);
    }
    throw response.body;
  }

  Future<List<User>> getAllUser() async {
    Uri url = Uri.parse("${AppConstand.BASE_URL}/users");

    final response = await http.get(url);

    if (response.statusCode == HttpStatus.ok) {
      return listUserFromJson(response.body);
    }
    throw response.body;
  }
}
