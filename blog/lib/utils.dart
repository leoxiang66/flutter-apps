import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

Future<void> go_to_url(String url, LaunchMode mode) async {
  final Uri uri = Uri.parse(url);

  try {
    await launchUrl(uri, mode: mode);
  } on PlatformException catch (e) {
    print('无法打开 URL，错误信息：$e');
  } on UnsupportedError catch (e) {
    print('不支持的平台，错误信息：$e');
  }
}

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


