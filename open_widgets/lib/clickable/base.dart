import 'package:flutter/material.dart';

class OpenClickable extends StatelessWidget {
  final Widget child;
  final VoidCallback onClick;
  final Color hoverColor;

  const OpenClickable({
    Key? key,
    required this.child,
    required this.onClick,
    this.hoverColor = Colors.black12,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: hoverColor,
      onTap: onClick,
      child: child,
    );
  }
}

class OpenCardClickable extends StatelessWidget {
  final Color hoverColor;
  final double width;
  final double height;
  final Widget child;
  final VoidCallback onClick;

  const OpenCardClickable({
    super.key,
    required this.child,
    required this.onClick,
    this.hoverColor = Colors.black12,
    this.width = -1,
    this.height = -1,
  });

  @override
  Widget build(BuildContext context) {
    if (width != -1 && height != -1) {
      return SizedBox(
        width: width, // 设置Card的宽度
        height: height,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: InkWell(
            hoverColor: hoverColor,
            onTap: onClick,
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              alignment: Alignment.center, // 让Card的child水平和垂直居中
              child: child,
            ),
          ),
        ),
      );
    } else if (width != -1) {
      return SizedBox(
        width: width, // 设置Card的宽度
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: InkWell(
            hoverColor: hoverColor,
            onTap: onClick,
            borderRadius: BorderRadius.circular(20.0),
            child: Center(heightFactor: 1, child: child),
          ),
        ),
      );
    } else if (height != -1) {
      return SizedBox(
        height: height, // 设置Card的宽度
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: InkWell(
            hoverColor: hoverColor,
            onTap: onClick,
            borderRadius: BorderRadius.circular(20.0),
            child: Center(widthFactor: 1, child: child),
          ),
        ),
      );
    } else {
      return SizedBox(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: InkWell(
            hoverColor: hoverColor,
            onTap: onClick,
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              child: child,
            ),
          ),
        ),
      );
    }
  }
}
