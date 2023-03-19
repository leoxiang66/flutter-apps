import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'scroll.dart';
import 'package:flutter/material.dart';
import '../blogs/blog1.dart';
import '../blogs/base.dart';
import '../blogs/blog2.dart';
import '../blogs/blog3.dart';
import 'base.dart';

class BlogDetailPage extends StatelessWidget {
  const BlogDetailPage({super.key, required this.blog});

  final MyBlog blog;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width * 0.5;

    return BasePage(
        widgets: DynMouseScroll(
            builder: (context, controller, physics) =>
                ListView(controller: controller, physics: physics, children: [
                  SizedBox(height: 30),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: width,
                      child: SelectableText(
                        blog.title,
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: width,
                      child: SelectableText(
                        blog.date.toString(),
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                        width: width,
                        child: SelectableText(
                          blog.content,
                          style: TextStyle(fontSize: 18),
                        )),
                  ),
                  SizedBox(height: 30),
                  Align(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                        ),
                        onPressed: () => {Navigator.pop(context)},
                        child: Text(
                          "Return",
                          style: TextStyle(fontSize: 20),
                        )),
                  ),
                ])));
  }
}
