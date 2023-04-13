import 'package:flutter/material.dart';

class OpenDrawer extends StatelessWidget {
  final String title;
  final Color primaryColor;
  final List<OpenDrawerItem> items;

  const OpenDrawer(
      {Key? key,
      required this.title,
      required this.items,
      this.primaryColor = Colors.blue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var drawheader_ = SizedBox(
      height: 60, // Set the desired height of the DrawerHeader
      child: DrawerHeader(
        decoration:BoxDecoration(
          color: primaryColor,
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white, // Set the text color to white
              fontWeight: FontWeight.bold, // Set the font weight to bold
            ),
          ),
        ),
      ),
    );

    var rendered = items.map((item) => item.build(context)).toList();
    rendered.insert(0, drawheader_);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: rendered,
      ),
    );
  }
}

class OpenDrawerItem extends StatelessWidget {
  const OpenDrawerItem({
    super.key,
    required this.icon,
    required this.text,
    required this.onMenuItemTapped,
  });

  final Function onMenuItemTapped;
  final Widget icon;
  final Text text;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: text,
      onTap: () {
        // Add your action here
        Navigator.pop(context);
        onMenuItemTapped();
      },
    );
  }
}

