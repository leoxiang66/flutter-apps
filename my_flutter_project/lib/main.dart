import 'package:flutter/material.dart';
import 'package:markdown_viewer/markdown_viewer.dart';
import 'package:open_widgets/navigator/utils.dart';
import 'package:open_widgets/navigator/web_navigator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    Center(
      child: Padding(
        padding: const EdgeInsets.all(100.0),
        child: welcome(),
      ),
    ),
    MyListViewWidget(items: ['hi', 'how are you', 'hello']),
    MarkdownViewer(
        "[leoxiang66.github.io](http://leoxiang66.github.io/)",
        onTapLink: (href, _) {
        go_to_url(href!);
      },
        
        )
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BottomNavigationBar Example'),
      ),
      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'message',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'contact',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

class welcome extends StatelessWidget {
  const welcome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MarkdownViewer('''
- 本app开发日期: 2024/3/16
- 开发者：向涛
      ''');
  }
}

class MyListViewWidget extends StatelessWidget {
  final List<String> items;

  MyListViewWidget({required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: Colors.grey[200],
            child: ListTile(
              title: Text(items[index]),
            ),
          ),
        );
      },
    );
  }
}
