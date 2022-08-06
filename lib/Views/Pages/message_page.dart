import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socketio_example/Models/chat_room_model.dart';
import 'package:socketio_example/Models/message_model.dart';
import 'package:socketio_example/Models/user_model.dart';
import 'package:socketio_example/Viewmodels/Providers/message_provider.dart';

class MessagePage extends StatelessWidget {
  final ChatRoom? chatRoom;
  final User user;
  const MessagePage({Key? key, required this.chatRoom, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var messageProvider = Provider.of<MessageProvider>(context);
    return Scaffold(
      backgroundColor: Color(0XFFe4e6e1),
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 4, 73, 7),
          titleSpacing: 0,
          title: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(user.image_url!),
              ),
              SizedBox(width: 10.0),
              Text(user.full_name!)
            ],
          )),
      body: FutureBuilder<List<Message>>(
        future: messageProvider.fetchMessage(chatRoom!.id!),
        builder: (BuildContext context, AsyncSnapshot<List<Message>> snapshot) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }

                    bool isMe = snapshot.data?[index].senderId ==
                        messageProvider.prefs.getString("currentUser");

                    return Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: isMe ? 2 : 10, horizontal: 8.0),
                      child: Align(
                        alignment:
                            isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.6),
                          padding: EdgeInsets.all(10.0),
                          // alignment: isMe
                          //     ? Alignment.centerRight
                          //     : Alignment.centerLeft,
                          // width: MediaQuery.of(context).size.width * 0.6,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: isMe ? Colors.blue[300] : Colors.white70),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(snapshot.data![index].message!),
                              Text(
                                "${snapshot.data![index].createdAt!.hour}:${snapshot.data![index].createdAt!.minute}",
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 12.0),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 6.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(40.0)),
                    child: TextField(
                      controller: messageProvider.messageController,
                      decoration: InputDecoration(
                        isDense: true, // Added this
                        contentPadding: EdgeInsets.all(10),
                        suffixIcon: IconButton(
                          onPressed: () {
                            List<String>? list = chatRoom?.users
                                ?.where((element) =>
                                    element !=
                                    messageProvider.prefs
                                        .getString("currentUser"))
                                .toList();
                            Message sendMessage = Message(
                              message: messageProvider.messageController.text,
                              senderId: messageProvider.prefs
                                  .getString("currentUser"),
                              receiverId: list?.first,
                              roomId: chatRoom?.id,
                            );
                            messageProvider.addMessage(sendMessage);
                            messageProvider.sendMessage();
                            messageProvider.messageController.clear();
                          },
                          icon: Icon(Icons.send),
                        ),
                        hintText: "Mesajınızı giriniz",

                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
