import 'package:flutter/material.dart';

class CustomClipperShape extends CustomClipper<Path>{
  @override
  Path getClip(Size s) {
    double h = s.height;
    double w = s.width;
    var p = Path();
    p.lineTo(0, h - h * 0.25);
    p.quadraticBezierTo(w * 0.1, h - h * 0.20,w * 0.20, h - h * 0.30);
    p.quadraticBezierTo(w * 0.40,h * 0.5,w * 0.60,h - h * 0.25);
    p.quadraticBezierTo(w * 0.75,h,w,h - h * 0.10);

    // p.lineTo(w/3, h/2);
    // p.lineTo(w - w/4, h);
    // p.lineTo(w, h - 10);
    p.lineTo(w, 0);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }

}