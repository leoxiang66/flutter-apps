import 'package:intl/intl.dart'; // 导入intl包

class formatDate{
  final int year;
  final int month;
  final int day;

  formatDate(
      {required this.year,
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
}




