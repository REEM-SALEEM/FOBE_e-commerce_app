import 'dart:ui';

import 'package:flutter/cupertino.dart';

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(
        0, size.height); //start path with this if you are making at bottom

    var firstStart = Offset(size.width / 5, size.height);
    //fist point of quadratic bezier curve
    var firstEnd = Offset(size.width / 2.25, size.height - 50.0);
    //second point of quadratic bezier curve
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    var secondStart =
        Offset(size.width - (size.width / 3.24), size.height - 105);
    //third point of quadratic bezier curve
    var secondEnd = Offset(size.width, size.height - 10);
    //fourth point of quadratic bezier curve
    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);

    path.lineTo(
        size.width, 0); //end with this path if you are making wave at bottom
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false; //if new instance have different instance than old instance
    //then you must return true;
  }}
  class WaveClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(
        0, size.height); //start path with this if you are making at bottom

    var firstStart = Offset(size.width / 5, size.height);
    //fist point of quadratic bezier curve
    var firstEnd = Offset(size.width / 2.25, size.height - 50.0);
    //second point of quadratic bezier curve
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    var secondStart =
        Offset(size.width - (size.width / 3.24), size.height - 105);
    //third point of quadratic bezier curve
    var secondEnd =Offset(size.width / 2, size.height); 
    // Offset(size.width, size.height - 10);
    //fourth point of quadratic bezier curve
    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);

    path.lineTo(
        size.width, 0); //end with this path if you are making wave at bottom
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false; //if new instance have different instance than old instance
    //then you must return true;
  }}
  //  class WaveClipper2 extends CustomClipper<Path> {
  // @override
  // Path getClip(Size size) {
  //   var path = Path();
  //   path.lineTo(
  //       0, size.height); //start path with this if you are making at bottom

  //   var firstStart = Offset(size.width / 5, size.height);
  //   //fist point of quadratic bezier curve
  //   var firstEnd = Offset(size.width / 2.25, size.height - 50.0);
  //   //second point of quadratic bezier curve
  //   path.quadraticBezierTo(
  //       firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

  //   var secondStart =
  //       Offset(size.width - (size.width / 7.10), size.height - 200);
  //   //third point of quadratic bezier curve
  //   var secondEnd =Offset(size.width / 2, size.height); 
  //   // Offset(size.width, size.height - 10);
  //   //fourth point of quadratic bezier curve
  //   path.quadraticBezierTo(
  //       secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);

  //   path.lineTo(
  //       size.width, 0); //end with this path if you are making wave at bottom
  //   path.close();
  //   return path;
  // }

  // @override
  // bool shouldReclip(CustomClipper<Path> oldClipper) {
  //   return false; //if new instance have different instance than old instance
  //   //then you must return true;
  // }}