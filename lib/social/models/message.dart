import 'social.dart';

/// think about creating a chat class wich
/// contains a list of messages

class Message {
  final Friend chatUser;
  final String
      time; // Would usually be type DateTime or Firebase Timestamp in production apps
  final String text;
  final bool isLiked;
  final bool unread;

  Message({
    required this.chatUser,
    required this.time,
    required this.text,
    required this.isLiked,
    required this.unread,
  });
}

class Chat {
  final String chatId;
  final String recentSender;

  final String recentMsg;
  final String time;

  Chat({
    required this.chatId,
    required this.recentSender,
    required this.recentMsg,
    required this.time,
  });
}

// YOU - current Friend
final Friend currentFriend = Friend(
    id: '0',
    name: 'Current Friend',
    imageUrl: 'assets/testImages/greg.jpg',
    chatId: '');

// FriendS
final Friend greg = Friend(
    id: '1', name: 'Greg', imageUrl: 'assets/testImages/greg.jpg', chatId: '');
final Friend james = Friend(
    id: 'RJAvaXqWkLbaqjcO0b8J2Cp0dyI3',
    name: 'James',
    imageUrl: 'assets/testImages/james.jpg',
    chatId: 'uHxvAABk5v7Xuk3fdU6Q');
final Friend john = Friend(
    id: '3', name: 'John', imageUrl: 'assets/testImages/john.jpg', chatId: '');
final Friend rihab = Friend(
    id: 'Cr6yLuvFnmTuEb2STGzKZ9fEO9d2',
    name: 'Rihab',
    imageUrl: 'assets/testImages/Profile Image.jpg',
    chatId: 'uHxvAABk5v7Xuk3fdU6Q');
final Friend sam = Friend(
    id: '5', name: 'Sam', imageUrl: 'assets/testImages/sam.jpg', chatId: '');
final Friend sophia = Friend(
    id: '6',
    name: 'Sophia',
    imageUrl: 'assets/testImages/sophia.jpg',
    chatId: '');
final Friend steven = Friend(
    id: '7',
    name: 'Steven',
    imageUrl: 'assets/testImages/steven.jpg',
    chatId: '');

// FAVORITE CONTACTS
List<Friend> favorites = [sam, james, john, greg];

// EXAMPLE CHATS ON HOME SCREEN
List<Chat> chats = [
  Chat(
    chatId: 'uHxvAABk5v7Xuk3fdU6Q',
    recentSender: 'james',
    time: '5:30 PM',
    recentMsg: 'Hey, how\'s it going? What did you do today?',
  ),
  Chat(
    chatId: 'uHxvAABk5v7Xuk3fdU6Q',
    recentSender: 'Rihab',
    time: '5:30 PM',
    recentMsg: 'Hey, how\'s it going? What did you do today?',
  ),
  Chat(
    chatId: '',
    recentSender: 'Jhon',
    time: '5:30 PM',
    recentMsg: 'Hey, how\'s it going? What did you do today?',
  ),
  Chat(
    chatId: '',
    recentSender: 'Sophia',
    time: '5:30 PM',
    recentMsg: 'Hey, how\'s it going? What did you do today?',
  ),
  Chat(
    chatId: '',
    recentSender: 'Steven',
    time: '5:30 PM',
    recentMsg: 'Hey, how\'s it going? What did you do today?',
  ),
];

// EXAMPLE MESSAGES IN CHAT SCREEN
List<Message> messages = [
  Message(
    chatUser: james,
    time: '5:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: true,
    unread: true,
  ),
  Message(
    chatUser: currentFriend,
    time: '4:30 PM',
    text: 'Just walked my doge. She was super duper cute. The best pupper!!',
    isLiked: false,
    unread: true,
  ),
  Message(
    chatUser: james,
    time: '3:45 PM',
    text: 'How\'s the doggo?',
    isLiked: false,
    unread: true,
  ),
  Message(
    chatUser: james,
    time: '3:15 PM',
    text: 'All the food',
    isLiked: true,
    unread: true,
  ),
  Message(
    chatUser: currentFriend,
    time: '2:30 PM',
    text: 'Nice! What kind of food did you eat?',
    isLiked: false,
    unread: true,
  ),
  Message(
    chatUser: james,
    time: '2:00 PM',
    text: 'I ate so much food today.',
    isLiked: false,
    unread: true,
  ),
];
