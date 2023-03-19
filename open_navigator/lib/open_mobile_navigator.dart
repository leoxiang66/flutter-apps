import 'package:flutter/material.dart';

/// A custom mobile navigation bar with customizable appearance.
class OpenMobileNavigator extends StatefulWidget {
  final List<OpenMobileNavigatorItem> items;
  final ValueChanged<int>? onTap;
  final int initialIndex;
  final Color primaryColor;
  final Color decorationColor;
  final Color inactiveColor;

  /// Creates an OpenMobileNavigator with the given configuration.
  ///
  /// [items] is the list of navigation items.
  /// [onTap] is an optional callback for handling item taps.
  /// [initialIndex] is the index of the initially selected item.
  /// [primaryColor] is the color for the selected item.
  /// [decorationColor] is the color for the background decoration.
  /// [inactiveColor] is the color for the non-selected items.
  const OpenMobileNavigator({super.key, 
    required this.items,
    this.onTap,
    this.initialIndex = 0,
    this.primaryColor = Colors.blue,
    this.decorationColor = Colors.white,
    this.inactiveColor = Colors.grey,
  }) : assert(items.length >= 2);

  @override
  _OpenMobileNavigatorState createState() => _OpenMobileNavigatorState();
}

/// The state for the [OpenMobileNavigator] widget.
class _OpenMobileNavigatorState extends State<OpenMobileNavigator> {
  int currentIndex;

  _OpenMobileNavigatorState() : currentIndex = 0;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      height: 60.0,
      decoration: BoxDecoration(
        color: widget.decorationColor,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: widget.items.map((item) {
          int index = widget.items.indexOf(item);
          return GestureDetector(
            onTap: () {
              setState(() {
                currentIndex = index;
              });
              if (widget.onTap != null) {
                widget.onTap!(index);
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color:
                      currentIndex == index ? widget.primaryColor : widget.inactiveColor,
                ),
                Text(
                  item.title,
                  style: TextStyle(
                    color: currentIndex == index
                        ? widget.primaryColor
                        : widget.inactiveColor,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}


/// Represents an item for the [OpenMobileNavigator] widget.
class OpenMobileNavigatorItem {
  final IconData icon;
  final String title;

  /// Creates an OpenNavigatorItem with the given [icon] and [title].
  OpenMobileNavigatorItem({required this.icon, required this.title});
}
