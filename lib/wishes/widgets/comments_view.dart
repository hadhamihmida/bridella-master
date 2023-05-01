import 'package:bridella/app_core/services/constants.dart';
import 'package:bridella/app_core/services/size_config.dart';
import 'package:bridella/users/models/user.dart';
import 'package:bridella/wishes/models/wish.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showCommentsView(BuildContext context, List<Comment> comments) {
  final user = Provider.of<BridellaUser>(context, listen: false);

  SizeConfig().init(context);
  showModalBottomSheet(
      backgroundColor: bridellaBGColor,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
      ),
      context: context,
      builder: (context) {
        //3
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return DraggableScrollableSheet(
              expand: false,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return commentsView(user, comments, scrollController);
              });
        });
      });
}

Widget commentsView(BridellaUser? user, List<Comment> comments,
    ScrollController? scrollController) {
  return Column(children: [
    Padding(
        padding: const EdgeInsets.all(8),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          ClipOval(
              child: Material(
            color: Colors.transparent,
            child: Ink.image(
              image: NetworkImage(user!.urlAvatar!),
              fit: BoxFit.cover,
              width: 40,
              height: 40,
            ),
          )),
          SizedBox(
              width: SizeConfig.screenWidth * .65,
              height: SizeConfig.screenWidth / 8,
              child: TextField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(4),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: kSecondaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: kPrimaryColor),
                    ),
                    border: InputBorder.none,
                    hintText: 'Enter your comment',
                  ),
                  onChanged: (value) {})),
          TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: kPrimaryColor,
              ),
              child: const Text(
                'Submit',
                style: TextStyle(fontWeight: FontWeight.bold),
              ))
        ])),
    comments.isEmpty
        ? const Center(
            child: Text('No comments to show here'),
          )
        : Expanded(
            child: ListView.separated(
                controller: scrollController,
                itemCount: comments.length,
                separatorBuilder: (__, _) {
                  return const Divider();
                },
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: ListTile(
                      leading: ClipOval(
                          child: Material(
                        color: Colors.transparent,
                        child: Ink.image(
                          image: const AssetImage('assets/avatar/v2.png'),
                          fit: BoxFit.cover,
                          width: 40,
                          height: 40,
                        ),
                      )),
                      title: const Text('I support u Rihab!'),
                      subtitle: const Text('Bridella User'),
                      trailing: const Text('1 week'),
                    ),
                  );
                }),
          )
  ]);
}
