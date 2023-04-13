import 'package:flutter/material.dart';

class OpenTextInput extends StatelessWidget {
  final void Function(String) onSubmitted;
  final void Function(String) onChanged;
  final String label;
  final double width;
  final int minLines;
  final int? maxLines;
  final String placeholder;
  final String? defaultValue;
  final TextEditingController _controller;

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
  })  : _controller = TextEditingController(text: defaultValue),
        super(key: key);

  void clearInput() {
    _controller.clear(); // 清空输入框
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextField(
        minLines: minLines,
        maxLines: maxLines,
        controller: _controller,
        decoration: InputDecoration(
          hintText: placeholder,
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        onChanged: (value) {
          onChanged(value);
        },
        onSubmitted: (value) {
          onSubmitted(value);
        },
      ),
    );
  }
}
