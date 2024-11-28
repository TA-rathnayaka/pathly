import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:pathly/models/path.dart';
import 'package:pathly/services/paths_service.dart';

class PathProvider extends ChangeNotifier {
  final PathsService pathService = PathsService();
  List<Path> _paths = [];

  PathProvider() {
    fetchPaths();
  }

  UnmodifiableListView<Path> get paths => UnmodifiableListView(_paths);

  Future<void> fetchPaths() async {
    _paths = await pathService.getPaths();
    notifyListeners();
  }

  void addPath(Path path) {
    _paths.add(path);
    notifyListeners();
  }

  void removePath(int index) {
    if (index >= 0 && index < _paths.length) {
      _paths.removeAt(index);
      notifyListeners();
    }
  }

  void updatePath(int index, Path updatedPath) {
    if (index >= 0 && index < _paths.length) {
      _paths[index] = updatedPath;
      notifyListeners();
    }
  }

  // Get path by name, handle case when no path is found
  Path? getPathByName(String name) {
    try {
      return _paths.firstWhere(
            (path) => path.name == name,
        orElse: () => Path(
          name: '',
          description: '',
          imageUrl: '',
          milestones: [],
          createdOn: DateTime.now(),
          modifiedOn: DateTime.now(),
        ),
      );
    } catch (e) {
      return null;
    }
  }
}