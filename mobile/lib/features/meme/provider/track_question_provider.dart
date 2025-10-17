import 'package:flutter/material.dart';

// tracks the question's length and status
class TrackQuestionProvider extends ChangeNotifier {
  int _current = 0;
  int _total = 0;
  bool _quizStatus = false;

  int get getCurrent => _current;

  bool get getQuizStatus => _quizStatus;
  int get getTotal => _total;

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
