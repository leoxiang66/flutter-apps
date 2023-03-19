import 'package:flutter/material.dart';
import 'package:open_widgets/navigator/drawer.dart';
import 'package:open_widgets/navigator/open_mobile_navigator.dart';
import 'package:open_widgets/navigator/utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'home.dart' show HomePage;
import 'about.dart' show AboutPage;

class BasePage extends StatelessWidget {
  const BasePage({
    super.key,
    required this.singleChildScrollView,
    // required this.onMenuItemTapped
  });

  final SingleChildScrollView singleChildScrollView;
  // final Function(int) onMenuItemTapped;

  @override
  Widget build(BuildContext context) {
    OpenDrawer mydrawer = OpenDrawer(
      title: "PEER",
      items: [
        OpenDrawerItem(
          icon: const FaIcon(
            FontAwesomeIcons.house,
            color: Colors.black,
          ),
          text: const Text('Home'),
          onMenuItemTapped: () =>
              {go_to_internal_page(context, const HomePage())},
        ),
        OpenDrawerItem(
          icon: const FaIcon(
            FontAwesomeIcons.userGraduate,
            color: Colors.black,
          ),
          text: const Text('About'),
          onMenuItemTapped: () =>
              {go_to_internal_page(context, const AboutPage())},
        ),
        OpenDrawerItem(
          icon: const FaIcon(
            FontAwesomeIcons.github,
            color: Colors.black,
          ),
          text: Text("GitHub"),
          onMenuItemTapped: () =>
              {go_to_url("https://github.com/Kasneci-Lab/AI-assisted-writing")},
        )
      ],
    );

    OpenMobileNavigator bottomNavigationBar = OpenMobileNavigator(
      items: [
        OpenMobileNavigatorItem(icon: Icons.home, title: "Home"),
        OpenMobileNavigatorItem(icon: Icons.hail, title: "hello")
      ],
    );

    var container = Container(
        height: 50,
        // color: Colors.red,
        child: Center(
          child: Text(
            "© 2022- ${DateTime.now().year} PEER",
            style: const TextStyle(
              color: Colors.black,
              // fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
      );
    return Scaffold(
      appBar: AppBar(
        title: const Text('PEER', style: TextStyle(color: Colors.white)),
        centerTitle: true, // Center the AppBar title
        backgroundColor: Colors.red, // Change the AppBar color to red
      ),
      drawer: mydrawer,
      body: singleChildScrollView,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
