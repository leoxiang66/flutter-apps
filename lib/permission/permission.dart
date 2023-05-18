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
    var status = await Permission.storage.status;
    if (status.isGranted) {
      setState(() {
        _isGranted = true;
      });
    } else {
      _requestPermission();
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
    return _isGranted
        ? widget.child
        : const Center(child: CircularProgressIndicator());
  }
}
