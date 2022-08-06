// import 'package:flutter/material.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

// import '../../Constand/app_constand.dart';

// class TestPage extends StatefulWidget {
//   const TestPage({Key? key}) : super(key: key);

//   @override
//   State<TestPage> createState() => _TestPageState();
// }

// class _TestPageState extends State<TestPage> {
//   late IO.Socket socket;

//   void connect() {
//     socket = IO.io("${AppConstand.BASE_URL}", <String, dynamic>{
//       "transports": ["websocket"],
//       "autoConnect": false,
//     });
//     socket.connect();
//     socket.onConnect((data) => print("Connected"));

//     socket.on("test", (data) => print(data));
//   }

//   @override
//   void initState() {
//     super.initState();
//     connect();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Text("Deneme"),
//       ),
//     );
//   }
// }
