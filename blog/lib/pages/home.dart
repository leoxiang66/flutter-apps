import 'package:blog/utils.dart';
import 'package:flutter/material.dart';
import '../blogs/blog1.dart';
import '../blogs/base.dart';
import '../blogs/blog2.dart';
import '../blogs/blog3.dart';
import 'base.dart';
import 'blog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var singleChildScrollView = SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ProfileWidget(),
          BlogSection(),
          Footer(),
        ],
      ),
    );

    return BasePage(singleChildScrollView: singleChildScrollView);
  }
}

class BlogSection extends StatelessWidget {
  const BlogSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          blogCard(context: context, blog: blog1),
          blogCard(context: context, blog: blog2),
          blogCard(context: context, blog: blog3),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              go_to_internal_page(context, BlogPage());
            },
            child: Text('All Blogs'),
          ),
        ],
      ),
    );
  }
}





class ProfileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
    padding: EdgeInsets.all(20),
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              width: 200,
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/avator.png'),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Leonhard Heung (向涛)',
              style: TextStyle(fontSize: 38,),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text('''🐈 Hey! I’m Leo, a CS student at Technical University of Munich.\nCheck out my blog posts below 🌈''',
            style: TextStyle(fontSize: 20),),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    FontAwesomeIcons.github,
                    color: Color(0xff2962ff),
                    size: 30,
                  ),
                ),
                SizedBox(
                  width: 25,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    FontAwesomeIcons.instagram,
                    color: Color(0xff2962ff),
                    size: 30,
                  ),
                ),
                SizedBox(
                  width: 25,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    FontAwesomeIcons.linkedin,
                    color: Color(0xff2962ff),
                    size: 30,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
