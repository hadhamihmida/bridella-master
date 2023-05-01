
import 'package:flutter/material.dart';

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    debugPrint(size.width.toString());
    var path = new Path();
    path.lineTo(0, size.height);
    var firstStart = Offset(size.width / 5, size.height);
    //first point of quadratic bezeir
    var firstEnd = Offset(size.width / 2.5, size.height - 50.0);
    // second point
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);
    var secondeStart =
        Offset(size.width - (size.width / 3.24), size.height - 105);
    //third point
    var secondEnd = Offset(size.width, size.height - 10);
    //fourth point
    path.quadraticBezierTo(
        secondeStart.dx, secondeStart.dy, secondEnd.dx, secondEnd.dy);
    //end with path
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }
  
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    throw UnimplementedError();
  }
}