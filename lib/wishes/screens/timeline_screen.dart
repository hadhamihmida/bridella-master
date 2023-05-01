import 'package:bridella/app_core/screens/Bridella_Scaffold.dart';
import 'package:bridella/dummy_data.dart';
import 'package:bridella/wishes/models/wish.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../../app_core/services/constants.dart';
import '../widgets/comments_view.dart';
import '../widgets/wish_card.dart';

class TimeLinePage extends StatefulWidget {
  static String routeName = "/time_line";
  const TimeLinePage({Key? key}) : super(key: key);

  @override
  State<TimeLinePage> createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
  final List<bool> isLiked = [for (Map<String, dynamic> _ in wishlist) false];

  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<List<Post>?>(context);
    print(posts);

    return SafeArea(
      child: posts == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : posts.isEmpty
              ? Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8),
                  child: const Text(
                    'When friends add wishes from marketplace, they will appear here.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
                  ),
                )
              : Column(children: [
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const Divider(
                        color: Color.fromARGB(255, 255, 235, 247),
                      ),
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        return WishCard(
                          wish: posts[index].wish,
                        );
                      },
                    ),
                  )
                ]),
    );
  }
}
