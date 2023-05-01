import 'package:flutter/material.dart';

import '../../app_core/services/constants.dart';
import '../../dummy_data.dart';

class StackedAvatars extends StatelessWidget {
  const StackedAvatars({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildStackedImages();
  }

  Widget buildStackedImages({
    TextDirection direction = TextDirection.ltr,
  }) {
    const double size = 34;
    const double xShift = 20;

    final items = urlImages.map((urlImage) => buildImage(urlImage)).toList();
    final allItems = items
        .asMap()
        .map((index, item) {
          const left = size - xShift;

          final value = Container(
            width: size,
            height: size,
            margin: EdgeInsets.only(left: left * index),
            child: item,
          );

          return MapEntry(index, value);
        })
        .values
        .toList();
    return Stack(
      children: /*direction == TextDirection.ltr
          ? allItems.reversed.toList()*/
          allItems.length < 4
              ? allItems
              : allItems.sublist(0, 2) +
                  [
                    Container(
                        width: size,
                        height: size,
                        margin: const EdgeInsets.only(left: 40),
                        child: ClipOval(
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(5),
                            color: bridellaBGColor,
                            child: const Text('+2'),
                          ),
                        ))
                  ],
    );
  }

  Widget buildImage(String urlImage) {
    const double borderSize = 5;

    return ClipOval(
      child: Container(
        padding: const EdgeInsets.all(borderSize),
        color: bridellaBGColor,
        child: ClipOval(
          child: Image.network(
            urlImage,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
