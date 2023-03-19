import 'package:flutter/material.dart';

class OpenWebNavigator extends StatefulWidget {
  final List<OpenWebNavigatorItem> items;
  final ValueChanged<int>? onTap;
  final int initialIndex;
  final Color primaryColor;
  final Color decorationColor;
  final Color inactiveColor;
  final Widget? logo;

  OpenWebNavigator({
    required this.items,
    this.onTap,
    this.initialIndex = 0,
    this.primaryColor = Colors.blue,
    this.decorationColor = Colors.white,
    this.inactiveColor = Colors.black,
    this.logo,
  }) : assert(items.length >= 2);

  @override
  _OpenWebNavigatorState createState() => _OpenWebNavigatorState();
}

class _OpenWebNavigatorState extends State<OpenWebNavigator> {
  int currentIndex;
  int? hoverIndex;

  _OpenWebNavigatorState() : currentIndex = 0;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      height: 80.0,
      decoration: BoxDecoration(
        color: widget.decorationColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (widget.logo != null) widget.logo!,
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: widget.items.map((item) {
                int index = widget.items.indexOf(item);
                return MouseRegion(
                  onEnter: (_) {
                    setState(() {
                      hoverIndex = index;
                    });
                  },
                  onExit: (_) {
                    setState(() {
                      hoverIndex = null;
                    });
                  },
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        currentIndex = index;
                      });
                      if (widget.onTap != null) {
                        widget.onTap!(index);
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Icon(
                          //   item.icon,
                          //   color: hoverIndex == index
                          //       ? widget.primaryColor
                          //       : widget.inactiveColor,
                          //   size: 24.0,
                          // ),
                          SizedBox(height: 4.0),
                          Text(
                            item.title,
                            style: TextStyle(
                              color: hoverIndex == index
                                  ? widget.primaryColor
                                  : widget.inactiveColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

/// Represents an item for the [OpenMobileNavigator] widget.
class OpenWebNavigatorItem {
  // final IconData icon;
  final String title;

  /// Creates an OpenNavigatorItem with the given [icon] and [title].
  OpenWebNavigatorItem({required this.title});
}
