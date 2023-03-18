import 'package:flutter/material.dart';
import 'sidebar.dart' show DrawerMenu, Drawer_;

class BasePage extends StatelessWidget {
  const BasePage({
    super.key,
    required this.singleChildScrollView,
    required this.onMenuItemTapped
  });


  final SingleChildScrollView singleChildScrollView;
  final Function(int) onMenuItemTapped;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PEER', style: TextStyle(color: Colors.white)),
        centerTitle: true, // Center the AppBar title
        backgroundColor: Colors.red, // Change the AppBar color to red
        leading: DrawerMenu(),
      ),
      drawer: Drawer_(onMenuItemTapped: onMenuItemTapped,),
      body: singleChildScrollView,
      bottomNavigationBar: Container(
        height: 50,
        // color: Colors.red,
        child: Center(
          child: Text(
            "© 2022- ${DateTime.now().year} PEER",
            style: TextStyle(
              color: Colors.black,
              // fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
