import 'package:bridella/app_core/services/constants.dart';
import 'package:bridella/app_core/services/show_snackbar.dart';
import 'package:bridella/social/models/social.dart';
import 'package:bridella/social/models/message.dart';
import 'package:bridella/users/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class SocialDataBase {
  // firestore references
  final CollectionReference _chats =
      FirebaseFirestore.instance.collection('chats');

  final CollectionReference _social =
      FirebaseFirestore.instance.collection('social');

  // get messages docs from firestore
  messagesStream(String chatId) async {
    try {
      return _chats
          .doc(chatId)
          .collection('messages')
          .orderBy('time', descending: true)
          .snapshots();
    } catch (e) {
      print(e);
      print('hereeeeeeeeeeeeeeeeeeeeeeeeeeeee');
    }
  }

  // send a message
  sendMessage(String chatId, Map<String, dynamic> chatMessageData) async {
    _chats.doc(chatId).collection('messages').add(chatMessageData);
    _chats.doc(chatId).update({
      "recentMessage": chatMessageData['message'],
      "recentSender": chatMessageData['recentSender'],
      "recentMessageTime": chatMessageData['time'].toString(),
    });
  }

  Stream<List<Chat>>? recentChats(List<String> chatList) {
    return _chats
        .where(FieldPath.documentId, arrayContains: chatList)
        .snapshots()
        .map((messages) => messages.docs.map((doc) {
              return Chat(
                chatId: doc.id,
                time: safeString(
                    doc['recentMessageTime'], DateTime.now().toString()),
                recentMsg: safeString(
                    doc['recentMessage'], 'Say Hi to your new friend.'),
                recentSender: safeString(doc['recentSender'], 'Bridella User'),
              );
            }).toList());
  }

  Social? socialFromFirestore(DocumentSnapshot snapshot) {
    try {
      if (snapshot.exists) {
        Map<String, dynamic> social = snapshot.data() as Map<String, dynamic>;
        // generating the friends list
        Map<String, dynamic> friends = social['friends'] ?? {};
        List<Friend>? friendsList = friends.isNotEmpty
            ? List<Friend>.from(friends.entries.map((friend) {
                Map<String, dynamic> friendData = friend.value;
                return Friend(
                    // the friend's ID is his email
                    id: friends.keys
                        .firstWhere((key) => friends[key] == friendData),
                    name: safeString(friendData['name'], 'Bridella User'),
                    imageUrl: safeString(friendData['avatar'], ''),
                    chatId: safeString(friendData['chatId'], ''));
              }))
            : [];
        // generating the friend requests list
        Map<String, dynamic> friendRequests = social['friend-requests'] ?? {};
        List<FriendRequest>? friendRequestsList = friendRequests.isNotEmpty
            ? List<FriendRequest>.from(friendRequests.entries.map((request) {
                Map<String, dynamic> requestData = request.value;

                return FriendRequest(
                  id: friendRequests.keys.firstWhere(
                      (element) => friendRequests[element] == requestData),
                  name: requestData['name'],
                  // on accepting friend generate a chat id and set it two the two social documents users
                  imageUrl: requestData['avatar'],
                );
              }))
            : [];

        return Social(
          fRequests: friendRequestsList,
          friends: friendsList,
        );

        // if we gonna acess the object from this object we define it as a list else as a map
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return Social(friends: [], fRequests: []);
    }
  }

  //Database serviniownerUser stream
  Stream<Social?> socialStream(String email) {
    return _social.doc(email).snapshots().map(socialFromFirestore);
  }

  // Send a Friend request to a friend using his email
  Future sendFriendRequest(String friendEmail, String userEmail,
      Map<String, dynamic> requestData) async {
    DocumentSnapshot friendRef = await _social.doc(friendEmail).get();

    if (friendRef.exists) {
      Map<String, dynamic> requests = friendRef.data() as Map<String, dynamic>;
      if (requests['friend-requests'][userEmail] != null) {
        message("this request is already sent");
      } else {
        _social
            .doc(friendEmail)
            .set(
              {
                'friend-requests': {userEmail: requestData}
              },
              SetOptions(merge: true),
            )
            .then((value) => message('Your request has been sent'))
            .catchError(
                (error) => message('Somthing went wrong. Please try later'));
      }
    } else {
      message("This email can't be found");
    }
  }

  Future acceptFriendRequest(
    String friendEmail,
    BridellaUser currentUser,
    FriendRequest request,
  ) async {
    try {
      // generate a chat document
      await _chats.add({
        "recentMessage": null,
        "recentSender": null,
        "recentMessageTime": null,
      }).then((doc) async {
        // then add the friend data (email,name,avatar,generated chat document Id)
        //to the current user social document
        await _social.doc(currentUser.email).set(
          {
            'friends': {
              friendEmail: {
                'avatar': '',
                'name': request.name,
                'chatId': doc.id
              }
            }
          },
          SetOptions(merge: true),
        );

        // And add the current user data (email,name,avatar,generated chat document Id)
        // to the friend social doc

        await _social.doc(friendEmail).set(
          {
            'friends': {
              currentUser.email!: {
                'avatar': currentUser.urlAvatar,
                'name': currentUser.displayName,
                'chatId': doc.id
              }
            }
          },
          SetOptions(merge: true),
        );
        // remove the data from friend request

        await _social.doc(currentUser.email).get();
        _social.doc(currentUser.email).set(
          {
            'friend-requests': {friendEmail: FieldValue.delete()}
          },
          SetOptions(merge: true),
        );
      });
    } catch (e) {
      print(e.toString());
      message(e.toString());
    }
  }

  Future declineFriendRequest(
    String friendEmail,
    String userEmail,
  ) async {
    await _social
        .doc(userEmail)
        .set({
          'friend-requests': {friendEmail: FieldValue.delete()}
        }, SetOptions(merge: true))
        .then((value) => message('Done'))
        .catchError(
            (error) => message('Somthing went wrong. Please try later'));
  }

  Future deleteFriend(
    String friendEmail,
    String userEmail,
  ) async {
    _social.doc(userEmail).set({
      'friends': {friendEmail: FieldValue.delete()}
    }, SetOptions(merge: true)).then((value) => _social
        .doc(friendEmail)
        .set({
          'friends': {userEmail: FieldValue.delete()}
        }, SetOptions(merge: true))
        .then((value) => message('Friend deleted'))
        .catchError(
            (error) => message('Somthing went wrong. Please try later')));
  }
  /* // todo
  Stream<List<Message>>? messagesFromFirebase(String uid, String fid) {
    final CollectionReference messages = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('chats')
        .doc(fid)
        .collection('messages');

    return messages
        .orderBy('time', descending: true)
        .snapshots()
        .map((messages) => messages.docs.map((doc) {
              return Message(
                chatUser: doc['chatUser'],
                time: doc['time'],
                text: doc['text'],
                isLiked: false, // for later implementation
                unread: false, // for later implementation
              );
            }).toList());
  } // */
}
