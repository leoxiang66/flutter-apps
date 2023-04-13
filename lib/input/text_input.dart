import 'package:flutter/material.dart';

class OpenTextInputProvider extends InheritedWidget {
  final TextEditingController controller;

  OpenTextInputProvider(
      {Key? key, required this.controller, required Widget child})
      : super(key: key, child: child);

  static OpenTextInputProvider? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<OpenTextInputProvider>();
  }

  @override
  bool updateShouldNotify(OpenTextInputProvider oldWidget) {
    return controller != oldWidget.controller;
  }
}




class OpenTextInput extends StatefulWidget {
  final void Function(String) onSubmitted;
  final void Function(String) onChanged;
  final String label;
  final double width;
  final int minLines;
  final int? maxLines;
  final String placeholder;
  final String defaultValue;
  final TextEditingController? controller;

  OpenTextInput({
    Key? key,
    required this.onSubmitted,
    required this.onChanged,
    required this.label,
    required this.width,
    this.controller,
    this.minLines = 1,
    this.maxLines = 1,
    this.placeholder = '',
    this.defaultValue = "",
  }) : super(key: key);

  @override
  OpenTextInputState createState() => OpenTextInputState();
}

class OpenTextInputState extends State<OpenTextInput> {
  TextEditingController? _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller = OpenTextInputProvider.of(context)?.controller;
  }

  void clearInput() {
    _controller?.clear(); // 清空输入框
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
