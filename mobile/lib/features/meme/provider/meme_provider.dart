import 'package:flutter/material.dart';
import 'package:mobile/features/meme/models/meme_response_model.dart';
import 'package:mobile/features/meme/viewModels/fetch_meme_service.dart';

class MemeProvider extends ChangeNotifier {
  bool _isLoading = false;
  MemeResponseModel? _memeResponse;

  bool get isLoading => _isLoading;
  MemeResponseModel? get memeResponse => _memeResponse;

  List<CachedAns> _cachedAnswer = [];

  int get totalCorrectAnswer =>
      _cachedAnswer.where((data) => data.isCorrect == true).length;

  List<CachedAns> get getCachedMemeAns => _cachedAnswer;

  Future<void> fetchMemes() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await FetchMemeService.getAllMemes();
      _memeResponse = response;
    } catch (e) {
      print("Error fetching memes: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearCache() {
    _cachedAnswer.clear();
    notifyListeners();
  }

  void addAnswer({required CachedAns data}) {
    // check if it exist
    var exist = _cachedAnswer.any((d) => d.id == data.id);

    if (!exist) {
      _cachedAnswer.add(data);
      notifyListeners();
    }
  }
}
