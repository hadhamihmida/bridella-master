import 'package:cloud_firestore/cloud_firestore.dart';

class Wish {
  final String wishId;
  final String tobuyId;
  final String ownerEmail;
  final String ownerName;
  final String ownerAvatar;
  final String? wishName;
  final double? price;
  final String? wishImg;
  final String? desc;
  final List<Comment> comments;
  final List<Like> likes;
  // final DateTime? createdAt;
  Wish({
    required this.wishId,
    required this.tobuyId,
    required this.ownerEmail,
    required this.ownerName,
    required this.ownerAvatar,
    this.wishName,
    this.price,
    this.wishImg,
    this.desc,
    required this.comments,
    required this.likes,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tobuyId': tobuyId,
      'ownerEmail': ownerEmail,
      'ownerName': ownerName,
      'ownerAvatar': ownerAvatar,
      'wishName': wishName,
      'wishImg': wishImg,
      'price': price,
      'desc': desc,
      'comments': {
        for (var comment in comments)
          comments.indexOf(comment).toString(): comment.toMap()
      },
      'likes': {
        for (var like in likes) likes.indexOf(like).toString(): like.toMap()
      },
    };
  }

  factory Wish.fromMap(Map<String, dynamic> map) {
    return Wish(
        wishId: map['wishId'] as String,
        tobuyId: map['tobuyId'] as String,
        ownerEmail: map['ownerEmail'] as String,
        ownerName: map['ownerName'] as String,
        ownerAvatar: map['ownerAvatar'] as String,
        price: map['price'] as double,
        wishName: map['wishName'] != null ? map['wishName'] as String : null,
        wishImg: map['wishImg'] != null ? map['wishImg'] as String : null,
        desc: map['desc'] != null ? map['desc'] as String : null,
        comments: [],
        likes: []);
  }
}

/* map['comments'] != {}
            ? map['comments']
                .values
                .map<Comment>((dynamic value) => Comment.fromMap(value))
                .toList()
            : [] */

class Like {
  final Timestamp timestamp;
  final String by;

  final String avatar;
  Like({
    required this.timestamp,
    required this.by,
    required this.avatar,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'timestamp': timestamp,
      'by': by,
      'avatar': avatar,
    };
  }

  factory Like.fromMap(Map<String, dynamic> map) {
    return Like(
      timestamp: map['timestamp'] as Timestamp,
      by: map['by'] as String,
      avatar: map['avatar'] as String,
    );
  }
}

class Comment {
  final Timestamp timestamp;
  final String by;
  final String avatar;
  final String content;
  Comment(
      {required this.timestamp,
      required this.by,
      required this.avatar,
      required this.content});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'timestamp': timestamp,
      'by': by,
      'avatar': avatar,
      'content': content
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
        timestamp: map['timestamp'],
        by: map['by'] as String,
        avatar: map['avatar'] as String,
        content: map['content'] as String);
  }
}

class Post {
  final Wish wish;

  Post({
    required this.wish,
  });
}
