import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../logger.dart' show logger;

void go_to_internal_page(BuildContext context, Widget page) {
  Navigator.pushReplacement(
    context,
    PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return page;
      },
      transitionDuration: Duration(milliseconds: 0),
      reverseTransitionDuration: Duration(milliseconds: 0),
    ),
  );
}

Future<void> go_to_url(String url) async {
  final Uri _url = Uri.parse(url);

  try {
    await launchUrl(_url);
  } on PlatformException catch (e) {
    logger.e('无法打开 URL，错误信息：$e');
  } on UnsupportedError catch (e) {
    logger.e('不支持的平台，错误信息：$e');
  }
}
