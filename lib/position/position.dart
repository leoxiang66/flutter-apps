import 'package:flutter/material.dart';

class FloatingCenterLeft extends StatelessWidget {
  final Widget child;
  final Widget pageBelow;

  const FloatingCenterLeft({super.key, required this.child, required this.pageBelow});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      pageBelow,
      Positioned(
        left: 0,
        top: 0,
        bottom: 0,
        child: child,
      ),
    ]);
  }
}
