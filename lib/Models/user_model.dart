import 'dart:convert';

List<User> listUserFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));
User userFromJson(String response) => User.fromJson(json.decode(response));
String userToJson(User user) => json.encode(user.toJson());

class User {
  final String? id;
  final String? full_name;
  final String? email;
  final String? password;
  final String? image_url;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    this.id,
    this.full_name,
    this.email,
    this.password,
    this.image_url,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        full_name: json["full_name"],
        email: json["email"],
        password: json["password"],
        image_url: json["image_url"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "full_name": full_name,
        "email": email,
        "password": password,
      };
}
