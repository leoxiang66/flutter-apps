import 'package:flutter/material.dart';

class EssayState extends ChangeNotifier {
  String _essayTitle = '';
  String? _essayType = '';
  String? _studyYear = '';

  String get essayTitle => _essayTitle;
  String? get essayType => _essayType;
  String? get studyYear => _studyYear;

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
}
