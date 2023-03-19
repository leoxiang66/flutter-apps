import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OpenSidebar extends StatefulWidget {
  @override
  _OpenSidebarState createState() => _OpenSidebarState();
}

class _OpenSidebarState extends State<OpenSidebar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      color: Colors.grey.shade800,
      child: ListView(
        children: [
          OpenSidebarItem(icon: FontAwesomeIcons.home, tooltip: "Home"),
          OpenSidebarItem(icon: FontAwesomeIcons.user, tooltip: "Profile"),
          OpenSidebarItem(icon: FontAwesomeIcons.search, tooltip: "Search"),
          OpenSidebarItem(icon: FontAwesomeIcons.cog, tooltip: "Settings"),
        ],
      ),
    );
  }
}

class OpenSidebarItem extends StatelessWidget {
  final IconData icon;
  final String tooltip;

  OpenSidebarItem({required this.icon, required this.tooltip});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: HoverCrossFadeWidget(
        firstChild: Icon(icon, color: Colors.white),
        secondChild: Tooltip(
          message: tooltip,
          child: Icon(icon, color: Colors.white),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.blue,
          ),
          textStyle: TextStyle(color: Colors.white),
          verticalOffset: 20,
          preferBelow: false,
        ),
        duration: Duration(milliseconds: 200),
      ),
    );
  }
}
