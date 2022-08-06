import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socketio_example/Constand/app_constand.dart';
import 'package:socketio_example/Models/chat_room_model.dart';
import 'package:socketio_example/Services/chat_room_service.dart';
import 'package:socketio_example/Viewmodels/Providers/chat_room_provider.dart';
import 'package:socketio_example/Views/Pages/message_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late IO.Socket socket;

  void connect() {
    socket = IO.io("${AppConstand.BASE_URL}", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    socket.onConnect((data) => print("Connected"));
  }

  @override
  void initState() {
    super.initState();
    connect();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ChatRoomProvider>(context);

    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: provider.users?.length,
        itemBuilder: (BuildContext context, int index) {
          // provider.fetchUserById(provider.rooms[index].senderId ?? "");
          if (!provider.isLoading) {
            return Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Center(child: Center(child: CircularProgressIndicator())),
            );
          }
          return InkWell(
            onTap: () async {
              // room oluştur
              String isRoom = await provider.isChatRoom(
                  provider.prefs.getString("currentUser")!,
                  provider.users![index].id!);
              print(isRoom);

              if (isRoom == "false") {
                ChatRoom room = await provider.AddChatRoom();

                socket.emit('create', room.id);

                //Kullanıcı Ekle
                provider.addUser(
                    provider.prefs.getString("currentUser")!, room.id!);
                provider.addUser(provider.users![index].id!, room.id!);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => MessagePage(
                              chatRoom: room,
                              user: provider.users![index],
                            )));
              } else {
                String rooms = isRoom.replaceAll("\"", "");
                print(rooms);
                ChatRoom chatRoom = await provider.fetchChatRoomById(rooms);

                socket.emit('create', chatRoom.id);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => MessagePage(
                              chatRoom: chatRoom,
                              user: provider.users![index],
                            )));
              }
            },
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage:
                    NetworkImage(provider.users![index].image_url!),
              ),
              title: Text(provider.users?[index].full_name ?? "Name"),
              subtitle: Text(provider.users?[index].email ?? "email"),
            ),
          );
        },
      ),
    );
  }
}
