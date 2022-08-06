import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socketio_example/Viewmodels/Providers/chat_room_provider.dart';
import 'package:socketio_example/Viewmodels/Providers/login_provider.dart';
import 'package:socketio_example/Viewmodels/Providers/message_provider.dart';
import 'package:socketio_example/Views/Pages/home_page.dart';
import 'package:socketio_example/Views/Pages/login_page.dart';

import 'Views/Pages/test.dart';

void main() => runApp(MultiProvider(
      child: const MyApp(),
      providers: [
        ChangeNotifierProvider<ChatRoomProvider>(
          create: (_) => ChatRoomProvider(),
        ),
        ChangeNotifierProvider<MessageProvider>(
          create: (_) => MessageProvider(),
        ),
        ChangeNotifierProvider<LoginProvider>(
          create: (_) => LoginProvider(),
        )
      ],
    ));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var loginProvider = Provider.of<LoginProvider>(context);
    return MaterialApp(
      title: 'Material App',
      home: loginProvider.isLogin ? HomePage() : LoginPage(),
    );
  }
}
