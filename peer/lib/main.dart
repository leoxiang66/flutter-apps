import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double imagePaddingValue = screenSize.width * 0.05; // Set image padding to 5% of screen width

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('PEER', style: TextStyle(color: Colors.white))),
        backgroundColor: Colors.red, // Change the AppBar color to red
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
            height: 60, // Set the desired height of the DrawerHeader
              child: DrawerHeader(
                child: Center(child: Text(
            'PEER',
            style: TextStyle(
              color: Colors.white, // Set the text color to white
              fontWeight: FontWeight.bold, // Set the font weight to bold
            ),
          ),),
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
              ),
            ),
            ListTile(
              title: Text('About'),
              onTap: () {
                // Add your action here
              },
            ),
            ListTile(
              title: Text('GitHub'),
              onTap: () {
                // Add your action here
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(imagePaddingValue, 0, imagePaddingValue, 0), // Set top and bottom padding to 0
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Image.network(
                      'https://raw.githubusercontent.com/Kasneci-Lab/AI-assisted-writing/ui/img/Peer_logo.png',
                      width: constraints.maxWidth,
                      fit: BoxFit.cover,
                    );
                  },
                ),
                SizedBox(height: imagePaddingValue),
                Text('PEER (Paper Evaluation and Empowerment Resource) is a cutting-edge application designed to empower researchers, students, and academics in their scholarly pursuits. This innovative platform offers a suite of powerful tools and resources that make it easy to evaluate, critique, and improve research papers, ensuring that they meet the highest standards of quality and rigor. Whether you are a seasoned researcher looking to refine your work, or a student just starting out on your academic journey, PEER is an invaluable resource that can help you achieve your goals and excel in your field. With its user-friendly interface and powerful features, PEER is the ultimate tool for anyone looking to take their research to the next level.'), // Add a text description below the image
                SizedBox(height: imagePaddingValue),
                ElevatedButton(
                  onPressed: () {
                    // Add your action here
                  },
                child: Text('Get Started', style: TextStyle(fontSize: 18)),
                  style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(screenSize.width * 0.4, screenSize.width * 0.15)),
              ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
