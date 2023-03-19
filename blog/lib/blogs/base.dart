import 'package:blog/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart'; // 导入intl包
import '../pages/blog_detail.dart';

class formatDate {
  final int year;
  final int month;
  final int day;

  formatDate({
    required this.year,
    required this.month,
    required this.day,
  });

  @override
  String toString() {
    return '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
  }
}

class MyBlog {
  final String title;
  final formatDate date;
  final String abstract;
  final String content;

  MyBlog(
      {required this.title,
      required this.date,
      required this.abstract,
      required this.content});

  void build_page(BuildContext context) {
    go_to_internal_page(
        context,
        BlogDetailPage(
          blog: this,
        ));
  }
}
