import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socketio_example/Constand/app_constand.dart';
import 'package:socketio_example/Models/user_model.dart';
import 'package:socketio_example/Services/user_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class LoginProvider with ChangeNotifier {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late UserService service;
  User? currentUser;
  late IO.Socket socket;
  late SharedPreferences prefs;

  bool _isLogin = false;
  bool get isLogin => _isLogin;
  set isLogin(bool value) {
    _isLogin = value;
    notifyListeners();
  }

  LoginProvider() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    service = UserService();
    connect();
    initializeSharedPreference();
  }

  Future<void> initializeSharedPreference() async {
    prefs = await SharedPreferences.getInstance();
  }

  void connect() {
    socket = IO.io(AppConstand.BASE_URL, <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();

    // socket.emit("test", "sockete bağlandı");
    socket.onConnect((data) => print("Connected burası "));
    socket.onDisconnect((data) => print("Disconnected"));
  }

  Future<void> loginWithEmailAndPassword() async {
    try {
      currentUser =
          await service.login(emailController.text, passwordController.text);
      isLogin = true;
      prefs.setBool("isLogin", isLogin);
      isLogin = prefs.getBool("isLogin")!;
      prefs.setString("currentUser", currentUser!.id ?? "");
      socket.emit("login", "${currentUser?.full_name} giriş yaptı");
      notifyListeners();
    } catch (e) {
      isLogin = false;
      print(e);
    }
  }
}
