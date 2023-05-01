import 'package:bridella/users/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_core/services/constants.dart';
import '../models/message.dart';
import '../models/social.dart';
import '../screens/chat_content_page.dart';

class ActiveContacts extends StatelessWidget {
  const ActiveContacts({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<BridellaUser>(context);
    //final social = Provider.of<Social>(context);
    final userSocial = Provider.of<Social?>(context);
    List<Friend> friendsList;
    if (userSocial != null) {
      friendsList = favorites + userSocial.friends;
    } else {
      friendsList = [];
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'Active Now',
                  style: TextStyle(
                    color: kTextColor,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.more_horiz,
                  ),
                  iconSize: 25.0,
                  color: kTextColor,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          SizedBox(
            height: 120.0,
            child: ListView.builder(
              padding: const EdgeInsets.only(left: 10.0),
              scrollDirection: Axis.horizontal,
              itemCount: friendsList.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatContentPage(
                        chatId: friendsList[index].chatId,
                        friend: friendsList[index],
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 25.0,
                          backgroundImage:
                              AssetImage(friendsList[index].imageUrl),
                          backgroundColor: kPrimaryLightColor,
                        ),
                        const SizedBox(height: 6.0),
                        Text(
                          friendsList[index].name,
                          style: const TextStyle(
                            color: kTextColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
