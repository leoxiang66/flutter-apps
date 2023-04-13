import 'dart:async';
import 'package:flutter/material.dart';

class Spinner extends StatelessWidget {
  final Future<dynamic> work;
  final Widget Function(dynamic) onFinished;

  const Spinner({super.key, required this.work, required this.onFinished});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: work,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // 显示spinner
        } else {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return onFinished(snapshot.data); // 显示结果
          }
        }
      },
    );
  }
}
