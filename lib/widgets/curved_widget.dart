import 'package:flutter/material.dart';

class CurvedWidget extends StatelessWidget {
  final Widget child;
  final double curvedDistance;
  final double curvedHeight;

  const CurvedWidget(
      {Key key, this.curvedDistance = 80, this.curvedHeight = 80, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CurvedWidgetBackgroundClipper(
        curvedDistance: curvedDistance,
        curverdHeight: curvedHeight,
      ),
      child: child,
    );
  }
}

class CurvedWidgetBackgroundClipper extends CustomClipper<Path> {
  final double curvedDistance;
  final double curverdHeight;

  CurvedWidgetBackgroundClipper({this.curvedDistance, this.curverdHeight});

  @override
  getClip(Size size) {
    Path clippedPath = Path();
    clippedPath.lineTo(size.width, 0);
    clippedPath.lineTo(
        size.width, size.height - curvedDistance - curverdHeight);
    clippedPath.quadraticBezierTo(size.width, size.height - curverdHeight,
        size.width - curvedDistance, size.height - curverdHeight);
    clippedPath.lineTo(curvedDistance, size.height - curverdHeight);
    clippedPath.quadraticBezierTo(
        0, size.height - curverdHeight, 0, size.height);
    return clippedPath;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}
