class Friend {
  final String id;
  final String name;
  final String imageUrl;
  final String chatId;
  // add other attributes that can be shown by visiting the profile

  Friend({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.chatId,
  });
}

class FriendRequest {
  final String id;
  final String name;
  final String imageUrl;

  FriendRequest({
    required this.id,
    required this.name,
    required this.imageUrl,
  });
}

class Social {
  final List<Friend> friends;
  final List<FriendRequest> fRequests;

  Social({
    required this.friends,
    required this.fRequests,
  });
}
