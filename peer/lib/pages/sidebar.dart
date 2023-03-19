import 'package:flutter/material.dart';
import 'home.dart' show HomePage;
import 'about.dart' show AboutPage;
import 'package:open_widgets/navigator/drawer.dart';
import 'package:open_widgets/navigator/utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



OpenDrawer mydrawer = OpenDrawer(title: "PEER",items: [
OpenDrawerItem(icon: FaIcon(FontAwesomeIcons.home,color: Colors.black,),text:Text('Home'),onMenuItemTapped: ()=>{


},)

],)


// class Drawer_ extends StatelessWidget {
//   final Function(int) onMenuItemTapped;

//   const Drawer_({Key? key, required this.onMenuItemTapped}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           SizedBox(
//           height: 60, // Set the desired height of the DrawerHeader
//             child: DrawerHeader(
//               child: Center(child: Text(
//           'PEER',
//           style: TextStyle(
//             color: Colors.white, // Set the text color to white
//             fontWeight: FontWeight.bold, // Set the font weight to bold
//           ),
//         ),),
//               decoration: BoxDecoration(
//                 color: Colors.red,
//               ),
//             ),
//           ),
          
//             ListTile(
//             leading: FaIcon(FontAwesomeIcons.home,color: Colors.black),
//             title: Text('Home'),
//             onTap: () {
//               // Add your action here
//               Navigator.pop(context);
//               onMenuItemTapped(0);
//             },
//           ),
//           ListTile(
//             leading: FaIcon(FontAwesomeIcons.userGraduate,color: Colors.black),
//             title: Text('About'),
//             onTap: () {
//               Navigator.pop(context);
//               onMenuItemTapped(1);
              
//             },
//           ),
//             ListTile(
//               leading: FaIcon(FontAwesomeIcons.github,color: Colors.black),
//               title: Text('GitHub'),
//               onTap: () {
//                 launch('https://github.com/Kasneci-Lab/AI-assisted-writing');
//                 Navigator.pop(context);
//               },
//             ),
//         ],
//       ),
//     );
//   }
// }

// class DrawerMenu extends StatelessWidget {
//   const DrawerMenu({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Builder(
//       builder: (BuildContext context) {
//         return IconButton(
//           icon: Icon(Icons.menu),
//           onPressed: () {
//             Scaffold.of(context).openDrawer();
//           },
//         );
//       },
//     );
//   }
// }