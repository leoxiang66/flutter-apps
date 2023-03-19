import 'package:blog/main.dart';
import 'package:flutter/material.dart';
import "package:blog/utils.dart";
import 'package:url_launcher/url_launcher.dart';
import '../blogs/base.dart';
import 'blog.dart' show BlogPage;
import '../utils.dart';
import 'scroll.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          navBarItem('Home', () {
            // 主页被点击时执行的操作
            print('主页按钮被点击');
            go_to_internal_page(context, MyHomePage());
          }),
          navBarItem('Blog', () {
            // 博客被点击时执行的操作
            print('博客按钮被点击');
            go_to_internal_page(context, BlogPage());
          }),
          navBarItem('More', () async {
            // 关于被点击时执行的操作
            print('关于按钮被点击');
            // 在单击时跳转到指定网站
            go_to_url('https://leoxiang66.github.io/',
                LaunchMode.externalApplication);
          }),
        ],
      ),
    );
  }

  Widget navBarItem(String title, VoidCallback onTap) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        onTap: onTap,
        child: Text(
          title,
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
    );
  }
}

class BasePage extends StatelessWidget {
  const BasePage({
    super.key,
    required this.widgets,
  });

  final DynMouseScroll widgets;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80), // 设置AppBar的高度
        child: NavBar(),
      ),
      body: Container(
        child: widgets,
        color: Color(0xfff7fafc),
      ),
      bottomNavigationBar: Container(
        height: 50,
        // color: Colors.red,
        child: Center(
          child: Text(
            "© 2022- ${DateTime.now().year} PEER",
            style: TextStyle(
              color: Colors.black,
              // fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
    )
    );
  }
}



class BlogCard extends StatelessWidget {
  const BlogCard({
    Key? key,
    required this.context,
    required this.blog,
    required this.onTap,
  }) : super(key: key);

  final BuildContext context;
  final MyBlog blog;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        margin: EdgeInsets.symmetric(vertical: 8),
        child: InkWell(
          borderRadius: BorderRadius.circular(20.0),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  blog.date.toString(),
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey),
                ),
                SizedBox(height: 8),
                Text(blog.abstract),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
