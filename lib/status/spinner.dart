import 'dart:async';
import 'package:flutter/material.dart';

class Spinner extends StatelessWidget {
  final Future<dynamic> future;
  final void Function(dynamic) onFinished;

  const Spinner({super.key, required this.future, required this.onFinished});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // 显示spinner
        } else {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            onFinished(snapshot.data);
            return const SizedBox(); // 显示结果
          }
        }
      },
    );
  }
}
