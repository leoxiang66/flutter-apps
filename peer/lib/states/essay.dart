import 'package:flutter/material.dart';

class EssayState extends ChangeNotifier {
  String _essayTitle = '';
  String? _essayType = '';
  String? _studyYear = '';
  String _essayContent = '';
  bool _textInput = false;

  String get essayTitle => _essayTitle;
  String? get essayType => _essayType;
  String? get studyYear => _studyYear;
  String get essayContent => _essayContent;
  bool get textInput => _textInput;

  void setTextInput() {
    _textInput = true;
    notifyListeners();
  }

  void setPhotoInput() {
    _textInput = false;
    notifyListeners();
  }

  void setEssayContent(String content) {
    _essayContent = content;
    notifyListeners();
  }

  void setEssayTitle(String title) {
    _essayTitle = title;
    notifyListeners();
  }

  void setEssayType(String? type) {
    _essayType = type;
    notifyListeners();
  }

  void setStudyYear(String? year) {
    _studyYear = year;
    notifyListeners();
  }

  bool essay_info_complete() {
    return _essayTitle != '' && _essayType != '' && _studyYear != '';
  }

  void setDefault() {
    _essayTitle = '';
    _essayType = '';
    _studyYear = "";
    _essayContent = '';
  }
}
