import 'package:bridella/app_core/services/constants.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

import '../models/wish.dart';
import 'comments_view.dart';

class WishCard extends StatefulWidget {
  WishCard({Key? key, required this.wish}) : super(key: key);
  Wish wish;

  @override
  State<WishCard> createState() => _WishCardState();
}

class _WishCardState extends State<WishCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 255, 249, 253),
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
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(widget.wish.ownerAvatar),
                backgroundColor: Colors.transparent,
              ),
              title: Text(widget.wish.ownerName,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 18, fontWeight: FontWeight.w600)),
              subtitle: Text(widget.wish.wishName!,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey)),
              trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_horiz,
                    color: kSecondaryColor,
                  )),
            ),
            widget.wish.desc!.isEmpty
                ? const SizedBox.shrink()
                : Text(
                    widget.wish.desc ?? '',
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
                    widget.wish.wishImg!,
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.contain,
                  ),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // Thumbs up BTN
                    IconButton(
                        onPressed: () => setState(() {
                              // then push it to firebase
                            }),
                        icon: const Icon(
                          UniconsLine.thumbs_up,
                          color: kSecondaryColor,
                        )),
                    // Comment BTN
                    IconButton(
                        onPressed: () =>
                            showCommentsView(context, widget.wish.comments),
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
            )
          ],
        ),
      ),
    );
  }
}
