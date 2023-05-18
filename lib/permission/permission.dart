import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionWidget extends StatefulWidget {
  final Widget child;
  const PermissionWidget({super.key, required this.child});

  @override
  _PermissionWidgetState createState() => _PermissionWidgetState();
}

class _PermissionWidgetState extends State<PermissionWidget> {
  bool _isGranted = false;

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  void _checkPermission() async {
    bool storage = true;
    bool videos = true;
    bool photos = true;

// Only check for storage < Android 13
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    if (androidInfo.version.sdkInt >= 33) {
      print(1);
      videos = await Permission.videos.status.isGranted;
      photos = await Permission.photos.status.isGranted;
    } else {
      storage = await Permission.storage.status.isGranted;
    }

    if (storage && videos && photos) {
      // Good to go!
      setState(() {
        _isGranted = true;
      });
    } else {
      // crap.
    }
  }

  void _requestPermission() async {
    var result = await Permission.storage.request();
    if (result.isGranted) {
      setState(() {
        _isGranted = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print(_isGranted);
    return _isGranted
        ? widget.child
        : const Center(child: CircularProgressIndicator());
  }
}
