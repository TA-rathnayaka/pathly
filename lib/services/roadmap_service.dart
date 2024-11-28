// import 'package:pathly/models/roadmap.dart';

// class RoadmapService {
//   // A list to store roadmaps
//   List<Roadmap> _roadmaps = [];

//   // Method to add a roadmap
//   void addRoadmap(Roadmap roadmap) {
//     _roadmaps.add(roadmap);
//   }

//   // Method to get all roadmaps
//   List<Roadmap> getRoadmaps() {
//     return _roadmaps;
//   }

//   // Method to get a roadmap by id
//   Roadmap getRoadmapById(String id) {
//     return _roadmaps.firstWhere((roadmap) => roadmap.id == id, orElse: () => null);
//   }

//   // Method to update a roadmap
//   void updateRoadmap(String id, Roadmap updatedRoadmap) {
//     int index = _roadmaps.indexWhere((roadmap) => roadmap.id == id);
//     if (index != -1) {
//       _roadmaps[index] = updatedRoadmap;
//     }
//   }

//   // Method to delete a roadmap
//   void deleteRoadmap(String id) {
//     _roadmaps.removeWhere((roadmap) => roadmap.id == id);
//   }
// }