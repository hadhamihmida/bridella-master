import 'package:flutter/material.dart';

import 'wishes/widgets/backfile.dart';

class backgg extends StatelessWidget {
  const backgg({super.key, required Scaffold child});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Opacity(
            opacity: 0.5,
            child: ClipPath(
              clipper: WaveClipper(),
              child: Container(
                color: Color.fromRGBO(225, 9, 157, 1),
                height: 200,
              ),
            ),
          ),
          ClipPath(
            clipper: WaveClipper(),
            child: Container(
              color: Color.fromARGB(255, 189, 4, 84),
              height: 180,
            ),
          ),
        ],
      ),
    );
  }
}


