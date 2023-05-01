import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../app_core/services/constants.dart';

Widget ratingChunk() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 4),
    decoration: BoxDecoration(
      color: kSecondaryColor.withOpacity(0.1),
      borderRadius: BorderRadius.circular(14),
    ),
    child: Row(
      children: [
        const Text(
          "4.5",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 5),
        SvgPicture.asset(
          "assets/icons/Star Icon.svg",
          color: Colors.orangeAccent,
        ),
      ],
    ),
  );
}
