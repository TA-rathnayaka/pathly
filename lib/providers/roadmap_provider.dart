import 'package:flutter/foundation.dart';

class RoadmapProvider with ChangeNotifier {
  Map<String, bool> _progress = {};

  Map<String, bool> get progress => _progress;

  void toggleStepCompletion(String step) {
    _progress[step] = !(_progress[step] ?? false);
    notifyListeners();
  }

  double getProgressPercentage() {
    int completed = _progress.values.where((val) => val).length;
    int total = _progress.length;
    return total == 0 ? 0.0 : (completed / total);
  }
}
