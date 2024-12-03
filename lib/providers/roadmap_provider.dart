import 'package:flutter/material.dart';
import 'package:pathly/services/roadmap_service.dart';
import 'package:pathly/models/roadmap.dart';
import 'package:pathly/models/roadmap_stage.dart';

class RoadmapProvider extends ChangeNotifier {
  final RoadmapService _roadmapService;

  RoadmapProvider(this._roadmapService) {
    fetchRoadmaps();
  }

  List<Roadmap> _roadmaps = [];

  List<Roadmap> get roadmaps => List.unmodifiable(_roadmaps);




  // Fetch all roadmaps from Firebase and keep a local copy
  Future<void> fetchRoadmaps() async {
    try {
      final fetchedRoadmaps = await _roadmapService.getRoadmaps();
      _roadmaps = fetchedRoadmaps;
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to fetch roadmaps: $e');
    }
  }
  Future<Roadmap> getRoadmap(String roadmapId) async {
    try {
      final fetchedRoadmap = await _roadmapService.getRoadmapById(roadmapId);
      return fetchedRoadmap;
    } catch (e) {
      throw Exception('Failed to fetch roadmap with ID $roadmapId: $e');
    }
  }

  Future<void> deleteRoadmap(String roadmapId) async {
    try {
      // Step 1: Remove the roadmap from the backend (Firestore)
      await _roadmapService.deleteRoadmap(roadmapId);

      // Step 2: Remove the roadmap from the local list
      _roadmaps.removeWhere((roadmap) => roadmap.id == roadmapId);

      // Step 3: Notify listeners to update the UI
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to delete roadmap: $e');
    }
  }

  Future<void> fetchRoadmapsByUid(String uid) async {
    try {
      // Fetch the roadmaps from the backend for the given UID
      final fetchedRoadmaps = await _roadmapService.getRoadmapsByUid(uid);

      // Update the local list of roadmaps with the fetched data
      _roadmaps = fetchedRoadmaps;

      // Notify listeners to update the UI
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to fetch roadmaps for UID $uid: $e');
    }
  }



  // Update a specific roadmap (title, description, icon, and imageUrl) both locally and in Firestore
  Future<void> updateRoadmap(
      String roadmapId,
      String updatedTitle,
      String updatedDescription,
      IconData updatedIcon,
      String updatedImageUrl,
      String updatedUid, // Add uid to the method
      ) async {
    try {
      // Step 1: Update the Firestore document
      await _roadmapService.updateRoadmap(roadmapId, updatedTitle, updatedDescription, updatedIcon, updatedImageUrl, updatedUid);

      // Step 2: Update the local list
      final roadmapIndex = _roadmaps.indexWhere((r) => r.id == roadmapId);
      if (roadmapIndex != -1) {
        _roadmaps[roadmapIndex] = Roadmap(
          id: roadmapId,
          title: updatedTitle,
          description: updatedDescription,
          icon: updatedIcon,
          imageUrl: updatedImageUrl,
          uid: updatedUid, // Update uid as well
          stages: _roadmaps[roadmapIndex].stages, // Keep the same stages
        );
        notifyListeners();
      } else {
        throw Exception('Roadmap with ID $roadmapId not found');
      }
    } catch (e) {
      throw Exception('Failed to update roadmap: $e');
    }
  }


  Future<String> addRoadmap(String title, String description, IconData icon, String imageUrl, String uid) async {
    try {
      // Add the roadmap to Firestore using the service method and get the roadmapId
      final roadmapId = await _roadmapService.addRoadmap(title, description, icon, imageUrl, uid);

      // After adding to Firestore, create a new Roadmap object locally with the generated ID
      final newRoadmap = Roadmap(
        id: roadmapId,  // Set the ID we just got from Firestore
        title: title,
        description: description,
        icon: icon,
        imageUrl: imageUrl, // Add imageUrl to the Roadmap object
        uid: uid, // Pass the uid
        stages: [],  // Initialize with no stages
      );
      print(newRoadmap);

      // Add the new roadmap to the local list
      _roadmaps.add(newRoadmap);

      // Notify listeners to update the UI
      notifyListeners();

      // Return the generated roadmapId
      return roadmapId;
    } catch (e) {
      throw Exception('Failed to add roadmap: $e');
    }
  }

  // Add a stage to a specific roadmap, both locally and in the backend
  void addStageToRoadmap(String roadmapId, RoadmapStage stage) async {
    try {
      // Find the roadmap by its ID
      final roadmapIndex = _roadmaps.indexWhere((r) => r.id == roadmapId);

      // Check if the roadmap was found
      if (roadmapIndex != -1) {
        // Add the new stage to the roadmap
        _roadmaps[roadmapIndex].stages.add(stage);

        // Also add the stage to the backend (Firestore or other service)
        await _roadmapService.addStageToRoadmap(roadmapId, stage);

        // Notify listeners to update the UI
        notifyListeners();
      } else {
        throw Exception('Roadmap with ID $roadmapId not found');
      }
    } catch (e) {
      throw Exception('Failed to add stage: $e');
    }
  }

  // Remove a stage from a specific roadmap, both locally and in the backend
  void removeStageFromRoadmap(String roadmapTitle, int stageIndex) async {
    try {
      final roadmapIndex = _roadmaps.indexWhere((r) => r.title == roadmapTitle);
      if (roadmapIndex != -1) {
        _roadmaps[roadmapIndex].stages.removeAt(stageIndex);
        await _roadmapService.removeStageFromRoadmap(roadmapTitle, stageIndex);
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Failed to remove stage: $e');
    }
  }

  // Update a stage in a specific roadmap, both locally and in the backend
  void updateStageInRoadmap(String roadmapTitle, int stageIndex, RoadmapStage updatedStage) async {
    try {
      final roadmapIndex = _roadmaps.indexWhere((r) => r.title == roadmapTitle);
      if (roadmapIndex != -1) {
        _roadmaps[roadmapIndex].stages[stageIndex] = updatedStage;
        await _roadmapService.updateStageInRoadmap(roadmapTitle, stageIndex, updatedStage);
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Failed to update stage: $e');
    }
  }
}