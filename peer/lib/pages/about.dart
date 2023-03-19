import 'package:flutter/material.dart';
import 'base.dart' show BasePage;


class AboutPage extends StatelessWidget {
  const AboutPage({
    Key? key,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double imagePaddingValue = screenSize.width * 0.05; // Set image padding to 5% of screen width
    return BasePage(
      singleChildScrollView: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(imagePaddingValue, 0, imagePaddingValue, 0),
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: imagePaddingValue),
                Text(
                  'About the Authors',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: imagePaddingValue),
                Text(
                  'Kathrin is a seasoned researcher and writer with a passion for helping others achieve their academic and professional goals. With years of experience in the field, she has a deep understanding of the challenges faced by researchers and students, and she is committed to creating innovative solutions that address these issues. In her free time, Kathrin enjoys reading, traveling, and spending time with her family.',
                ),
                SizedBox(height: imagePaddingValue),
                Text(
                  'Tao is an accomplished software engineer and researcher with a strong background in artificial intelligence and machine learning. He has worked on numerous cutting-edge projects and has a proven track record of delivering high-quality results. Tao is passionate about empowering others through technology and is dedicated to creating tools that make a positive impact on people\'s lives. When he\'s not coding or working on new ideas, Tao enjoys hiking, photography, and exploring new places.',
                ),
                SizedBox(height: imagePaddingValue),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
