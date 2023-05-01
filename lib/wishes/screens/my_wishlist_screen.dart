import 'package:bridella/wishes/models/wish.dart';
import 'package:bridella/wishes/services/wish_db.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_core/services/constants.dart';
import '../../app_core/services/size_config.dart';
import '../../app_core/widgets/custom_app_bar.dart';
import '../../app_core/widgets/default_button.dart';

class MywishlistBridge extends StatelessWidget {
  static String routeName = "/my_wishlist_screen";
  const MywishlistBridge({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Wish>? wishs = Provider.of<List<Wish>?>(context);
    return MyWishlistPage(
      wishs: wishs ?? [],
    );
  }
}

class MyWishlistPage extends StatefulWidget {
  // static String routeName = "/my_wish_list_page";
  MyWishlistPage({super.key, required this.wishs});
  List<Wish> wishs;
  @override
  State<MyWishlistPage> createState() => _MyWishlistPageState();
}

class _MyWishlistPageState extends State<MyWishlistPage> {
  List<bool> _isExpanded = [];
  List<bool> _isLiked = [];
  List<bool> showChildren = [];

  @override
  Widget build(BuildContext context) {
    final wishDB = WishDataBase();
    SizeConfig().init(context);
    print(widget.wishs.length);
    print(_isExpanded.length);
    if (_isExpanded.length != widget.wishs.length) {
      _isExpanded = [];
      _isLiked = [];
      showChildren = [];
      for (var _ in widget.wishs) {
        setState(() {
          _isExpanded.add(false);
          _isLiked.add(false);
          showChildren.add(false);
        });
        print("here");
      }
    }
    return Scaffold(
      appBar: ClassicAppBar.defaultAppBar(context,
          title: 'My wishlist', actions: []),
      body: SafeArea(
        child: _isExpanded.length != widget.wishs.length
            ? const Center(
                child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ),
              )
            : widget.wishs.isEmpty
                ? emptyWishes(context)
                : Column(children: [
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) => const Divider(
                          color: Colors.white,
                        ),
                        itemCount: widget.wishs.length,
                        itemBuilder: (context, index) {
                          Wish wish = widget.wishs[index];
                          return Card(
                            color: bridellaBGColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            elevation: 2,
                            //color: ,
                            margin: const EdgeInsets.only(bottom: 4),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    contentPadding: const EdgeInsets.all(0),
                                    title: Text(wish.wishName!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600)),
                                    subtitle: Text('${wish.price} dt'),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ExpandIcon(
                                          isExpanded: _isExpanded[index],
                                          color: kSecondaryColor,
                                          expandedColor: kPrimaryColor,
                                          disabledColor: Colors.grey,
                                          onPressed: (bool isExpanded) {
                                            setState(() {
                                              _isExpanded[index] =
                                                  !_isExpanded[index];
                                              // hide children when not expanded
                                              _isExpanded[index] == false
                                                  ? showChildren[index] = false
                                                  : null;
                                            });
                                          },
                                        ),
                                        PopupMenuButton(
                                            onSelected: (value) {
                                              if (value == WishAction.delete) {
                                                wishDB.deleteWish(wish.wishId);
                                              } else if (value ==
                                                  WishAction.edit) {
                                                // todo
                                              }
                                            },
                                            itemBuilder: ((context) => [
                                                  const PopupMenuItem(
                                                      value: WishAction.delete,
                                                      child: Text('Delete')),
                                                  /*      const PopupMenuItem(
                                                      value: WishAction.edit,
                                                      child: Text('Edit'))*/
                                                ]))
                                      ],
                                    ),
                                  ),
                                  wish.desc!.isEmpty
                                      ? const SizedBox.shrink()
                                      : Text(
                                          widget.wishs[index].desc!,
                                          textAlign: TextAlign.left,
                                        ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Container(
                                        color: kSecondaryColor.withOpacity(0.1),
                                        child: Image.network(
                                          wish.wishImg!,
                                          height: 100,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          fit: BoxFit.contain,
                                        ),
                                      )),
                                  AnimatedContainer(
                                    onEnd: () => setState(() {
                                      // show children when completely expanded
                                      _isExpanded[index] == true
                                          ? showChildren[index] = true
                                          : null;
                                    }),
                                    duration: const Duration(milliseconds: 300),
                                    height: _isExpanded[
                                            index] /*&& there's comments*/
                                        ? SizeConfig.screenWidth * 0.5
                                        : 0,
                                    child: showChildren[index]
                                        ? widget.wishs[index].comments.isEmpty
                                            ? const Center(
                                                child:
                                                    Text('No Comments to show'),
                                              )
                                            : ListView.separated(
                                                itemCount: widget.wishs[index]
                                                    .comments.length,
                                                separatorBuilder: (__, _) {
                                                  return const Divider();
                                                },
                                                itemBuilder: (context, index) {
                                                  Wish wish =
                                                      widget.wishs[index];
                                                  return InkWell(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: ListTile(
                                                      leading: ClipOval(
                                                          child: Material(
                                                        color:
                                                            Colors.transparent,
                                                        child: Ink.image(
                                                          image: NetworkImage(
                                                              wish
                                                                  .comments[
                                                                      index]
                                                                  .avatar),
                                                          fit: BoxFit.cover,
                                                          width: 40,
                                                          height: 40,
                                                        ),
                                                      )),
                                                      title: Text(wish
                                                          .comments[index]
                                                          .content),
                                                      subtitle: Text(wish
                                                          .comments[index].by),
                                                      trailing: Text(wish
                                                          .comments[index]
                                                          .timestamp
                                                          .toString()),
                                                    ),
                                                  );
                                                }) /*Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        // Thumbs up BTN
                                        IconButton(
                                            onPressed: () => setState(() {
                                                  isLiked[index] = !isLiked[
                                                      index]; // then push it to firebase
                                                }),
                                            icon: Icon(
                                              UniconsLine.thumbs_up,
                                              color: isLiked[index]
                                                  ? kPrimaryColor
                                                  : kSecondaryColor,
                                            )),
                                        // Comment BTN
                                        IconButton(
                                            onPressed: () =>
                                                showCommentsView(context),
                                            icon: const Icon(
                                              UniconsLine.comment_lines,
                                              color: kSecondaryColor,
                                            ))
                                        // when comments get pressed , the card get expanded to see the comments and to type a new comment
                                      ],
                                    ),
                                    // Share BTN
                                    const IconButton(
                                        onPressed: null,
                                        icon: Icon(
                                          UniconsLine.telegram_alt,
                                          color: kSecondaryColor,
                                        ))
                                  ],
                                )*/
                                        : null,
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ]),
      ),
    );
  }

  Widget emptyWishes(BuildContext context) => Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          AspectRatio(
              aspectRatio: 1.5,
              child: Image.asset('assets/testImages/emty_wishlist.gif')),
          const Text(
              'Your wishlist is empty?\n'
              'Add some wishes from the marketplace!',
              textAlign: TextAlign.center),
          const SizedBox(height: 8.0),
          DefaultButton(
            padding: const EdgeInsets.only(left: 8, right: 8),
            text: 'Browse Products',
            press: () {
              Navigator.pop(context);
            },
          )
        ]),
      );
}

class DropDownMenu extends StatelessWidget {
  final List<PopupMenuEntry> menuList;
  final Color color;
  final Widget icon;
  const DropDownMenu(
      {required this.menuList,
      this.color = Colors.white,
      this.icon = const Icon(
        Icons.more_vert,
        color: Color(0xff4338CA),
      ),
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: color,
      icon: icon,
      itemBuilder: (BuildContext context) => menuList,
    );
  }
}

enum WishAction { delete, edit }
