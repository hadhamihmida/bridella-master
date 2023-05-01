import 'package:bridella/app_core/services/constants.dart';
import 'package:bridella/social/screens/chat_content_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/message.dart';
import '../models/social.dart';

class RecentChats extends StatelessWidget {
  const RecentChats({super.key});

  @override
  Widget build(BuildContext context) {
    //  final social = Provider.of<Social>(context);
    // final chatList = Provider.of<List<Chat>>(context); concatinate this list with the test list
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: bridellaBGColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (BuildContext context, int index) {
              final Friend friend = favorites[index];
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatContentPage(
                      chatId: friend.chatId,
                      friend: Friend(
                          chatId: friend.chatId,
                          name: friend.name,
                          imageUrl: friend.imageUrl,
                          id: ''),
                    ),
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.only(
                    top: 5.0,
                    bottom: 5.0, /* right: 20.0 */
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  decoration: const BoxDecoration(
                    color: bridellaBGColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 25.0,
                            backgroundColor: kPrimaryLightColor,
                            backgroundImage: AssetImage(friend.imageUrl),
                          ),
                          const SizedBox(width: 10.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                friend.name,
                                style: const TextStyle(
                                  color: kSecondaryColor,
                                  //     fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: const Text(
                                  'hello ',
                                  style: TextStyle(
                                    color: kTextColor, //Colors.blueGrey,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: const <Widget>[
                          Text(
                            '5:30 PM',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5.0),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
