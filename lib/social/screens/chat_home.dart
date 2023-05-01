import 'package:bridella/app_core/services/constants.dart';
import 'package:bridella/social/models/social.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_core/services/animation.dart';
import '../widgets/active_contacts.dart';
import '../widgets/recent_chats.dart';

class ChatHome extends StatefulWidget {
  static String routeName = "/chat_home";

  const ChatHome({super.key});

  @override
  ChatHomeState createState() => ChatHomeState();
}

class ChatHomeState extends State<ChatHome> {
  @override
  Widget build(BuildContext context) {
    final social = Provider.of<Social?>(context);
    final List<Friend> friendLists =
        social != null ? List<Friend>.from(social.friends) : [];
    return Column(
      children: <Widget>[
        // CategorySelector(),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: kSecondaryColor.withOpacity(0.05),
            ),
            child: Column(
              children: const <Widget>[
                ActiveContacts(),
                Expanded(
                  child: FadeAnimation(
                      transFactor: 60.0, delay: 0.8, child: RecentChats()),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
