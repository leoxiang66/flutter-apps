import 'package:flutter/material.dart';

class EssayState extends ChangeNotifier {
  String _essayTitle = '';
  String? _essayType = '';
  String? _studyYear = '';
  String _essayContent = '';

  String get essayTitle => _essayTitle;
  String? get essayType => _essayType;
  String? get studyYear => _studyYear;
  String get essayContent => _essayContent;

  void setEssayContent(String content) {
    _essayContent = content;
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
    return _essayTitle != '' &&
        _essayType != '' &&
        _studyYear != '' &&
        _essayContent != '';
  }

  void setDefault() {
    _essayTitle = '';
    _essayType = '';
    _studyYear = "";
    _essayContent = '';
  }
}
