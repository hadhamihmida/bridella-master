import 'package:bridella/social/models/social.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_core/services/constants.dart';

class PopupFriendsView extends StatefulWidget {
  List<Friend> friendAssignment;
  PopupFriendsView({super.key, required this.friendAssignment});

  @override
  State<PopupFriendsView> createState() => _PopupFriendsViewState();
}

class _PopupFriendsViewState extends State<PopupFriendsView> {
  @override
  Widget build(BuildContext context) {
    final userSocial = Provider.of<Social?>(context);
    List<Friend> friendAssignment = widget.friendAssignment;
    return userSocial == null
        ? const SizedBox(
            height: 10,
            width: 10,
          )
        : userSocial.friends.isEmpty
            ? const Center(
                child: Text(
                'This task is not shared with any friends.',
                textAlign: TextAlign.center,
              ))
            : ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: userSocial.friends.length,
                itemBuilder: (context, i) {
                  Friend friend = userSocial.friends[i];
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                          friend.imageUrl.isEmpty ? avatar : friend.imageUrl),
                    ),
                    title: Text(friend.name),
                    trailing: Checkbox(
                      value: true,
                      onChanged: (_) {},
                    ),
                  );
                });
  }

  DropdownButton dropdownOtpions(
    List<Friend> friends,
  ) {
    //  bool editPressed = false;

    return DropdownButton(
      hint: const Text('Assign to'),
      items: friends.map((Friend friend) {
        return DropdownMenuItem<String>(
          value: friend.id,
          child: Text(friend.name),
        );
      }).toList(),
      onChanged: (newvalue) {
        setState(() {
          if (widget.friendAssignment.any((friend) => friend.id == newvalue)) {
            return;
          } else {
            Friend friend =
                friends.firstWhere((friend) => friend.id == newvalue);
            widget.friendAssignment.add(friend);
          }
        });
      },
    );
  }
}
