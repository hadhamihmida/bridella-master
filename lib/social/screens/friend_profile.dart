import 'package:bridella/social/models/social.dart';
import 'package:bridella/wishes/models/wish.dart';
import 'package:bridella/wishes/widgets/wish_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_core/services/size_config.dart';
import '../../app_core/widgets/custom_app_bar.dart';

class FriendProfile extends StatelessWidget {
  static String routeName = "/friend_profile";

  FriendProfile({Key? key, required this.f}) : super(key: key);
  Friend f;

  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<List<Post>>(context);
    List<Post> friendWishes = posts
        .where(
          (element) => element.wish.ownerEmail == f.id,
        )
        .toList();
    return Scaffold(
      appBar: ClassicAppBar.defaultAppBar(
        context,
        title: f.name,
        actions: [],
      ),
      body: SafeArea(
          child: Column(children: [
        SizedBox(height: getProportionateScreenWidth(10)),
        SizedBox(
          height: SizeConfig.screenHeight * .25,
          child: Column(
            //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 80,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(14)),
                        image: DecorationImage(
                            image: NetworkImage(f.imageUrl.isNotEmpty
                                ? f.imageUrl
                                : 'https://firebasestorage.googleapis.com/v0/b/bridella-eb876.appspot.com/o/users%2Fv2.png?alt=media&token=40d9e936-a88d-46f8-87b6-e07db6c9b3cc'))),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                f.name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(f.id),
            ],
          ),
        ),
        Expanded(
            child: friendWishes.isEmpty
                ? Center(
                    child:
                        Text("${f.name} has not added any wish to his list "),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: friendWishes.length,

                    //bizList.length,
                    itemBuilder: (_, index) {
                      Wish wish = friendWishes[index].wish;

                      return WishCard(wish: wish);
                    },
                  ))
      ])),
    );
  }
}
