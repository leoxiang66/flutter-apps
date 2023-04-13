import 'package:flutter/material.dart';

class OpenTextInput extends StatefulWidget {
  final void Function(String) onSubmitted;
  final void Function(String) onChanged;
  final String label;
  final double width;
  final int minLines;
  final int? maxLines;
  final String placeholder;
  final String? defaultValue;
  void Function()? clearInput;

  OpenTextInput({
    Key? key,
    required this.onSubmitted,
    required this.onChanged,
    required this.label,
    required this.width,
    this.minLines = 1,
    this.maxLines = 1,
    this.placeholder = '',
    this.defaultValue,
    this.clearInput,
  }) : super(key: key);

  @override
  _OpenTextInputState createState() => _OpenTextInputState();
}

class _OpenTextInputState extends State<OpenTextInput> {
  late TextEditingController _controller;

  void _clearInput() {
    _controller.clear(); // 清空输入框
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.defaultValue); // 设置默认值
    widget.clearInput = _clearInput; // 将清除功能分配给回调
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: TextField(
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        controller: _controller,
        decoration: InputDecoration(
          hintText: widget.placeholder,
          labelText: widget.label,
          border: const OutlineInputBorder(),
        ),
        onChanged: (value) {
          widget.onChanged(value);
        },
        onSubmitted: (value) {
          widget.onSubmitted(value);
        },
      ),
    );
  }
}
