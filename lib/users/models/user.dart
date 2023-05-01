class BridellaUser {
  final String uid;
  final AcountType? accType;
  final String? displayName;
  final String? urlAvatar;
  final String? partnerAvatar;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final String? bio;
  final String? address;
  final bool? verfied;
  final String? phoneNumber;
  final Map<String, String>? userChats;
  final String? weddingDate;

  BridellaUser({
    required this.uid,
    required this.accType,
    this.displayName,
    this.urlAvatar,
    this.partnerAvatar,
    this.email,
    this.firstName,
    this.lastName,
    this.gender,
    this.bio,
    this.verfied = false,
    this.address,
    this.phoneNumber,
    this.userChats = const {},
    this.weddingDate,
  });
}

enum AcountType { bride, groom, guest }
