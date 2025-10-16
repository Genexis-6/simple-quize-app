import 'package:flutter/material.dart';

class TrackQuestionProvider extends ChangeNotifier {
  int _current = 0;
  int _total = 0;
  bool _quizStatus = false;

  int get getCurrent => _current;

  bool get getQuizStatus => _quizStatus;

  void reset() {
    _current = 0;
    _quizStatus = false;
    notifyListeners();
  }

  void next() {
    if (_current < _total - 1) {
      _current += 1;
    } else {
      _quizStatus = true;
      
    }
    notifyListeners();
  }

  int get getTotal => _total;

  void setTotal(int n) {
    _total = n;
    notifyListeners();
  }

  void prev() {
    if (_current > 0) {
      _current -= 1;
    }
  }
}
