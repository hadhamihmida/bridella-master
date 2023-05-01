import 'package:bridella/app_core/services/constants.dart';
import 'package:bridella/social/screens/friend_profile.dart';
import 'package:bridella/social/services/social_db.dart';
import 'package:bridella/users/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../app_core/services/show_snackbar.dart';
import '../../app_core/services/size_config.dart';
import '../models/social.dart';

class FriendsPage extends StatefulWidget {
  static String routeName = "/friends_page";
  const FriendsPage({Key? key}) : super(key: key);

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  static const List _options = ['Requestes', 'Friends List'];
  int _selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            actions: [searchBTN(context)],
            bottom: TabBar(
              tabs: [
                Tab(
                    icon: Text(
                  'Friend Requests',
                  style: ts(),
                )),
                Tab(icon: Text('Friends', style: ts())),
              ],
            ),
            title: const Text(
              'Friends',
              style: TextStyle(color: kSecondaryColor),
            ),
            leading: IconButton(
              icon: SvgPicture.asset(
                "assets/icons/Back ICon.svg",
                color: kSecondaryColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: TabBarView(
              children: [friendsRequestsView(context), friendsView(context)],
            ),
          ),
        ));
  }

  Widget friendsRequestsView(BuildContext context) {
    final userSocial = Provider.of<Social?>(context);
    final user = Provider.of<BridellaUser>(context);
    List<FriendRequest> friendRequestsList;
    if (userSocial != null) {
      friendRequestsList = userSocial.fRequests;
    } else {
      friendRequestsList = [];
    }
    SocialDataBase socialDB = SocialDataBase();

    return friendRequestsList.isEmpty
        ? const Center(child: Text('No Requests to show'))
        : ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: friendRequestsList.length,
            itemBuilder: (context, index) {
              FriendRequest friendRequest = friendRequestsList[index];
              return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  elevation: 1,
                  //color: ,

                  margin: const EdgeInsets.only(bottom: 4),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 18,
                      backgroundImage: NetworkImage(friendRequest
                              .imageUrl.isEmpty
                          ? 'https://firebasestorage.googleapis.com/v0/b/bridella-eb876.appspot.com/o/users%2Fv2.png?alt=media&token=40d9e936-a88d-46f8-87b6-e07db6c9b3cc'
                          : friendRequest.imageUrl),
                      backgroundColor: kPrimaryLightColor,
                    ),
                    title: Text(
                      friendRequest.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // DECLINE BTN
                        /* ClipOval(
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: kSecondaryColor, width: 2),
                              color: bridellaBGColor,
                              shape: BoxShape.circle,
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                  child: const Icon(
                                    Icons.close,
                                    color: kSecondaryColor,
                                  ),
                                  onTap: () {
                                    /// don't just delete the user from the map but make a bool variable
                                    /// called : deleted=true then fetch all requestest where deleted == false
                                    ///
                                    socialDB
                                        .declineFriendRequest(
                                            friendRequest.id, user.email!)
                                        .onError((_, __) => showSnackBar(
                                            context, 'Somthing went wrong'));
                                  }),
                            ),
                          ),
                        ), */
                        SizedBox(
                          height: SizeConfig.screenWidth * 0.1,
                          width: SizeConfig.screenWidth * 0.23,
                          child: ElevatedButton(
                            onPressed: () {
                              socialDB
                                  .acceptFriendRequest(
                                      friendRequest.id, user, friendRequest)
                                  .onError((_, __) => showSnackBar(
                                      context, 'Somthing went wrong'));

                              // push to friens map
                            },
                            style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: kPrimaryColor),
                            child: const Text('Accept'),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        SizedBox(
                            height: SizeConfig.screenWidth * 0.1,
                            width: SizeConfig.screenWidth * 0.23,
                            child: ElevatedButton(
                                onPressed: () {
                                  /// don't just delete the user from the map but make a bool variable
                                  /// called : deleted=true then fetch all requestest where deleted == false
                                  ///
                                  socialDB
                                      .declineFriendRequest(
                                          friendRequest.id, user.email!)
                                      .onError((_, __) => showSnackBar(
                                          context, 'Somthing went wrong'));
                                },
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.grey),
                                child: const Text('Refuse'))),

                        // ACCEPT BTN
                        /*  ClipOval(
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 36, 179, 109),
                                  width: 2),
                              color: const Color.fromARGB(255, 36, 179, 109),
                              shape: BoxShape.circle,
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                  child: const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  ),
                                  onTap: () {
                                    socialDB
                                        .acceptFriendRequest(friendRequest.id,
                                            user, friendRequest)
                                        .onError((_, __) => showSnackBar(
                                            context, 'Somthing went wrong'));
                                    ;
                                    // push to friens map
                                  }),
                            ),
                          ),
                        ), */
                      ],
                    ),
                  ));
            });
  }

  Widget friendsView(BuildContext context) {
    final userSocial = Provider.of<Social?>(context);
    final user = Provider.of<BridellaUser>(context);
    List<Friend> friendsList;
    if (userSocial != null) {
      friendsList = userSocial.friends;
    } else {
      friendsList = [];
    }

    return friendsList.isEmpty
        ? const Center(child: Text('No friends to show'))
        : ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: friendsList.length,
            itemBuilder: (context, index) {
              Friend friend = friendsList[index];
              return GestureDetector(
                onTap: (() => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FriendProfile(
                          f: friend,
                        ),
                      ),
                    )),
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    elevation: 1,
                    //color: ,

                    margin: const EdgeInsets.only(bottom: 4),
                    child: Slidable(
                      endActionPane:
                          ActionPane(motion: const DrawerMotion(), children:

                              // if the product is certified bridella we can't plan it (plan action not available)
                              [
                        // sa : SlidableAction
                        sa(Colors.redAccent, 'Block', (c) {}),

                        sa(const Color.fromARGB(255, 206, 206, 206), 'Delete',
                            (c) {
                          socialDB.deleteFriend(friend.id, user.email!);
                        })
                      ]),
                      child: ListTile(
                        title: Text(friend.name),
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(friend.imageUrl.isEmpty
                              ? 'https://firebasestorage.googleapis.com/v0/b/bridella-eb876.appspot.com/o/users%2Fv2.png?alt=media&token=40d9e936-a88d-46f8-87b6-e07db6c9b3cc'
                              : friend.imageUrl),
                          backgroundColor: kPrimaryLightColor,
                        ),
                      ),
                    )),
              );
            });
  }

  Widget buildoptions() {
    return Container(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(12)),
      height: 40,
      child: ListView.separated(
        itemCount: _options.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: _buildCatItem,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(width: 12);
        },
      ),
    );
  }

  void _onTapItem(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  Widget _buildCatItem(BuildContext context, int index) {
    final isActive = _selectIndex == index;
    const radius = BorderRadius.all(Radius.circular(16));
    return Container(
      decoration: BoxDecoration(
        borderRadius: radius,
        color: isActive
            ? kPrimaryColor //const Color.fromARGB(255, 46, 44, 44)
            : const Color(0xFFFFFFFF),
      ),
      alignment: Alignment.center,
      child: InkWell(
        borderRadius: radius,
        onTap: () => _onTapItem(index),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(2, 6, 2, 6),
          child: Text(
            _options[index].toString(),
            style: TextStyle(
              color: isActive
                  ? const Color(0xFFFFFFFF)
                  : kPrimaryColor, // const Color.fromARGB(255, 46, 44, 44),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  final Map<String, dynamic> requestData = {};
  bool loading = false;
  SocialDataBase socialDB = SocialDataBase();

  Widget searchBTN(BuildContext context) {
    final user = Provider.of<BridellaUser>(context);
    final formKey = GlobalKey<FormState>();
    final userSocial = Provider.of<Social?>(context);
    final List<String> friendsEmails = [];
    final List<String> frequestsEmails = [];
    if (userSocial != null) {
      for (var friend in userSocial.friends) {
        friendsEmails.add(friend.id);
      }
      for (var friendRequest in userSocial.fRequests) {
        frequestsEmails.add(friendRequest.id);
      }
    }
    TextEditingController email = TextEditingController();

    return CircleAvatar(
      radius: 30,
      backgroundColor: bridellaBGColor,
      child: ClipOval(
        child: SizedBox(
          width: 38,
          height: 38,
          child: Material(
              color: Colors.white,
              child: InkWell(
                child: const Icon(
                  Icons.search,
                  color: kPrimaryColor,
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => Form(
                          key: formKey,
                          child: AlertDialog(
                            //   backgroundColor: kPrimaryColor,
                            title: const Center(
                              child: Text(
                                "Enter your friend's email",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0))),
                            contentPadding: const EdgeInsets.all(0),
                            content: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                        alignment: Alignment.center,
                                        width: SizeConfig.screenWidth * 0.6,
                                        height: SizeConfig.screenWidth / 4,
                                        child: TextFormField(
                                          controller: email,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "The email can't be empty";
                                            } else if (!emailValidatorRegExp
                                                .hasMatch(value)) {
                                              return "The email is invalid";
                                            } else if (friendsEmails
                                                .contains(email.text)) {
                                              return "Friend already exist";
                                            } else if (user.email ==
                                                email.text) {
                                              return "You can't send yourself a friend request";
                                            } else if (frequestsEmails
                                                .contains(email.text)) {
                                              return "This friend has already sent you a friend request ";
                                            }
                                            return null;
                                          },
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: const InputDecoration(
                                            contentPadding: EdgeInsets.all(4),
                                            errorMaxLines: 2,
                                            enabledBorder: OutlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: kTextColor),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: kPrimaryColor),
                                            ),
                                            hintText: "example@bridella.com",
                                          ),
                                        )),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    width: SizeConfig.screenWidth * 0.4,
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: getProportionateScreenHeight(56),
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(25.0),
                                                  bottomRight:
                                                      Radius.circular(25.0))),
                                          foregroundColor: bridellaBGColor,
                                          backgroundColor: kPrimaryColor,
                                        ),
                                        onPressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            setState(() {
                                              loading = true;

                                              requestData['name'] =
                                                  user.displayName;
                                              requestData['avatar'] =
                                                  user.urlAvatar;
                                            });

                                            if (user.email != null) {
                                              print(email.text);
                                              socialDB
                                                  .sendFriendRequest(email.text,
                                                      user.email!, requestData)
                                                  .then((value) {
                                                setState(() {
                                                  loading = false;
                                                });

                                                Navigator.pop(context);
                                              });
                                            } else {
                                              setState(() {
                                                showSnackBar(context,
                                                    'Somthing went wrong');

                                                loading = false;
                                              });
                                            }
                                          }
                                        },
                                        child: Text(
                                          'Send friend Request',
                                          style: TextStyle(
                                            fontSize:
                                                getProportionateScreenWidth(18),
                                            color: bridellaBGColor,
                                          ),
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                          )));
                },
              )),
        ),
      ),
    );
  }

  TextStyle ts() => const TextStyle(color: Colors.black, fontSize: 12);
}
