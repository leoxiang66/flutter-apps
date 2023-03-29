import 'package:flutter/material.dart';
import 'pages/home.dart' show HomePage;
import 'package:provider/provider.dart';
import 'states/essay.dart' show EssayState;

/// This is the main function of the app.
void main() {
  runApp(MyApp());
}

/// This is the main widget of the app.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
    create: (context) => EssayState(),
      child: MaterialApp(
        title: 'PEER - Paper Evaluation and Empowerment Resource',
        home: HomePage(),
      ),
    );
  }
}

/// This is the home page widget of the app.
// class MyHomePage extends StatefulWidget {
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   var selectedIndex = 0;

//   void handleMenuItemTapped(int index) {
//     setState(() {
//       selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
    

//     Widget page;
//       switch (selectedIndex) {
//         case 0:
//           page = HomePage();
//           break;
//         case 1:
//           page = AboutPage(onMenuItemTapped: handleMenuItemTapped,);
//           break;
//         default:
//           throw UnimplementedError('no widget for $selectedIndex');
//       } 

//     return page;
//   }
// }




