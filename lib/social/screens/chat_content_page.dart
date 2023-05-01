import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_core/services/constants.dart';
import '../../users/models/user.dart';
import '../models/social.dart';
import '../models/message.dart';
import '../services/social_db.dart';

class ChatContentPage extends StatefulWidget {
  static String routeName = "/chat_c_page";
  final String chatId;
  final Friend friend;

  const ChatContentPage({
    super.key,
    required this.chatId,
    required this.friend,
  });

  @override
  ChatContentPageState createState() => ChatContentPageState();
}

class ChatContentPageState extends State<ChatContentPage> {
  _buildMessage(Message message, bool isMe) {
    final Container msg = Container(
      margin: isMe
          ? const EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              left: 80.0,
            )
          : const EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
            ),
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
        // BG
        color: isMe ? Colors.white : kPrimaryLightColor,
        borderRadius: isMe
            ? const BorderRadius.only(
                topLeft: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0),
              )
            : const BorderRadius.only(
                topRight: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            message.time,
            style: TextStyle(
              // TIME
              color: isMe ? kPrimaryColor : kTextColor,
              fontSize: 12.0,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            message.text,
            style: TextStyle(
                // TEXT MESSAGE
                color: isMe ? kTextColor : kTextColor,
                fontSize: 16.0,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
    if (isMe) {
      return msg;
    }
    return Row(
      children: <Widget>[
        msg,
        IconButton(
          icon: message.isLiked
              ? const Icon(Icons.favorite)
              : const Icon(Icons.favorite_border),
          iconSize: 30.0,
          color: kPrimaryColor,
          onPressed: () {},
        )
      ],
    );
  }

  TextEditingController messageController = TextEditingController();

  _buildMessageComposer(BridellaUser currentUser) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 75.0,
      color: bridellaBGColor,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.photo),
            iconSize: 25.0,
            color: kSecondaryColor,
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
                controller: messageController,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  hintText: 'Type somthing...',
                  contentPadding: EdgeInsets.only(left: 4),
                )),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            iconSize: 25.0,
            color: kSecondaryColor,
            onPressed: () {
              Map<String, dynamic> chatMessageMap = {
                "message": messageController.text,
                "sender": currentUser.uid,
                "time": DateTime.now().millisecondsSinceEpoch,
              };
              messageController.text = '';
              SocialDataBase().sendMessage(widget.chatId, chatMessageMap);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<BridellaUser>(context);
    return Scaffold(
      backgroundColor: bridellaBGColor,
      appBar: AppBar(
        backgroundColor: bridellaBGColor,
        title: Text(
          widget.friend.name,
          style: const TextStyle(
            color: kTextColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.more_horiz),
            iconSize: 30.0,
            color: kTextColor,
            onPressed: () {},
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: bridellaBGColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                    child: chatMessages(context, currentUser)),
              ),
            ),
            _buildMessageComposer(currentUser),
          ],
        ),
      ),
    );
  }

  Widget chatMessages(BuildContext context, BridellaUser currentUser) {
    print(userMessages == null);
    print('test test test test tets tets');
    return userMessages != null
        ? StreamBuilder(
            stream: userMessages,
            builder: (context, AsyncSnapshot snapshot) {
              print("mama");
              return snapshot.hasData
                  ? ListView.builder(
                      reverse: true,
                      padding: const EdgeInsets.only(top: 15.0),
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        print("here.");
                        final bool isMe = snapshot.data.docs[index]['sender'] ==
                            currentUser.uid;

                        return _buildMessage(
                            Message(
                                chatUser: Friend(
                                    chatId: '',
                                    name: snapshot.data.docs[index]['sender'],
                                    imageUrl: '',
                                    id: ""),
                                time: snapshot.data.docs[index]['time']
                                    .toString(),
                                text: snapshot.data.docs[index]['message'],
                                isLiked: false,
                                unread: false),
                            isMe);
                      },
                    )
                  : Center(child: Text('Say Hi to ${widget.friend.name}'));
            },
          )
        : const Center(
            child: CircularProgressIndicator(
            color: kPrimaryColor,
          ));
  }

  Stream<QuerySnapshot>? userMessages;

  @override
  void initState() {
    getChats();
    super.initState();
  }

  getChats() {
    SocialDataBase().messagesStream(widget.chatId).then((val) {
      setState(() {
        userMessages = val;
      });
    });
  }
}
