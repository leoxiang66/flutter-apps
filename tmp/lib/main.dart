import 'package:dyn_mouse_scroll/dyn_mouse_scroll.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BasicUsageApp());
}

class BasicUsageApp extends StatelessWidget {
  const BasicUsageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: DynMouseScroll(
              builder: (context, controller, physics) => SingleChildScrollView(
                    controller: controller,
                    physics: physics,
                    child: Center(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: 200,
                            color: Colors.black,),
                            SizedBox(height: 100,),
                            Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 200,
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 200,
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 200,
                          color: Colors.black,
                        )
                      ],),
                    )
                  ))),
    );
  }
}

class LinkedPhysicsApp extends StatelessWidget {
  const LinkedPhysicsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Center(
                child: Column(children: [
      Expanded(
          child: Row(children: const [
        MyScrollingWidget(height: 100, colors: [Colors.blue, Colors.red]),
        MyScrollingWidget(height: 200, colors: [Colors.yellow, Colors.green]),
      ])),
      Expanded(
          child: Row(children: const [
        MyScrollingWidget(height: 150, colors: [Colors.purple, Colors.orange]),
        MyScrollingWidget(height: 80, colors: [Colors.black, Colors.white])
      ]))
    ]))));
  }
}

class MyScrollingWidget extends StatelessWidget {
  final List<Color> colors;
  final double height;
  const MyScrollingWidget(
      {Key? key, required this.colors, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: DynMouseScroll(
            builder: (context, controller, physics) => ListView(
                  controller: controller,
                  physics: physics,
                  children: List.generate(
                      50,
                      (index) => Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: height,
                          color: (index % 2 == 0) ? colors[0] : colors[1])),
                )));
  }
}
