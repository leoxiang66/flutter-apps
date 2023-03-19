import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


class OpenSidebar extends StatelessWidget {
  final List<OpenSidebarItem> children;

  OpenSidebar({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      color: Colors.white,
      child: Column(
        children: children
            .map((item) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 25),
                  child: item,
                ))
            .toList(),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OpenSidebarItem extends StatefulWidget {
  final Widget icon;
  final String tooltip;

  OpenSidebarItem({required this.icon, required this.tooltip});

  @override
  _OpenSidebarItemState createState() => _OpenSidebarItemState();
}

class _OpenSidebarItemState extends State<OpenSidebarItem> {
  bool _isHovered = false;

  void _onEnter(PointerEnterEvent event) {
    setState(() {
      _isHovered = true;
    });
  }

  void _onExit(PointerExitEvent event) {
    setState(() {
      _isHovered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: _onEnter,
      onExit: _onExit,
      child: _isHovered
          ? Tooltip(
              message: widget.tooltip,
              child: widget.icon,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.blue,
              ),
              textStyle: TextStyle(color: Colors.white),
              verticalOffset: 20,
              preferBelow: true,
            )
          :widget.icon,
    );
  }
}
