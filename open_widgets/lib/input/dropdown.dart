import 'package:flutter/material.dart';

class OpenDropdown extends StatefulWidget {
  final String hint;
  final List<String> items;
  final void Function(String?) onChanged;
  final double width;
  // final double height;

  const OpenDropdown(
      {super.key,
      required this.hint,
      required this.items,
      required this.onChanged, required this.width,});

  @override
  _OpenDropdownState createState() => _OpenDropdownState();
}

class _OpenDropdownState extends State<OpenDropdown> {
  String? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: DropdownButton<String>(
        value: _selectedValue,
        hint: Text(widget.hint),
        items: widget.items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedValue = newValue;
          });
          widget.onChanged(newValue);
        },
      ),
    );
  }
}
