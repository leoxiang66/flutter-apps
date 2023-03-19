import 'scroll.dart';
import 'package:flutter/material.dart';
import '../blogs/blog1.dart';
import '../blogs/base.dart';
import '../blogs/blog2.dart';
import '../blogs/blog3.dart';
import '../blogs/blog4.dart';
import '../blogs/blog5.dart';
import '../blogs/blog6.dart';
import 'base.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({
    Key? key,
  }) : super(key: key);

  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  int currentPage = 1;

  void nextPage() {
    setState(() {
      currentPage++;
    });
  }

  void previousPage() {
    setState(() {
      if (currentPage > 1) {
        currentPage--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var singleChildScrollView = SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlogView(
            currentPage: currentPage,
            onNextPage: nextPage,
            onPreviousPage: previousPage,
          ),
        ],
      ),
    );

    return BasePage(
        widgets: DynMouseScroll(
            builder: (context, controller, physics) => SingleChildScrollView(
                  controller: controller,
                  physics: physics,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BlogView(
                          currentPage: currentPage,
                          onNextPage: nextPage,
                          onPreviousPage: previousPage,
                        ),
                      ],
                    ),
                  ),
                )));
  }
}

class BlogView extends StatelessWidget {
  final int currentPage;
  final VoidCallback onNextPage;
  final VoidCallback onPreviousPage;
  final int blogsPerPage = 5;
  final List<MyBlog> allBlogs = [
    blog1,
    blog2,
    blog3,
    blog4,
    blog5,
    blog6
    // Add more blogs here
  ];

  BlogView({
    required this.currentPage,
    required this.onNextPage,
    required this.onPreviousPage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topCenter, // 添加这一行
            child: ListView.builder(
              shrinkWrap: true, // Add this line
              physics: NeverScrollableScrollPhysics(), // Add this line
              itemCount: blogsPerPage,
              itemBuilder: (BuildContext context, int index) {
                int blogIndex = (currentPage - 1) * blogsPerPage + index;
                if (blogIndex < allBlogs.length) {
                  return BlogCard(
                    context: context,
                    blog: allBlogs[blogIndex],
                    onTap: () {
                      allBlogs[blogIndex].build_page(context);
                    },
                  );
                } else {
                  return SizedBox
                      .shrink(); // Do not display anything if there are no more blogs
                }
              },
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 16),
              if (currentPage > 1)
                ElevatedButton(
                  onPressed: onPreviousPage,
                  child: Text('上一页'),
                ),
              Spacer(),
              if ((currentPage) * blogsPerPage < allBlogs.length)
                ElevatedButton(
                  onPressed: onNextPage,
                  child: Text('下一页'),
                ),
              SizedBox(width: 16),
            ],
          ),
        ],
      ),
    );
  }
}
