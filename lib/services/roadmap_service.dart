import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pathly/models/roadmap.dart';
import 'package:pathly/models/roadmap_stage.dart';

class RoadmapService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch all roadmaps from Firestore
  Future<List<Roadmap>> getRoadmaps() async {
    try {
      final snapshot = await _firestore.collection('roadmaps').get();
      return snapshot.docs.map((doc) {
        var stagesData = doc['stages'] as List?;
        return Roadmap(
          title: doc['title'],
          description: doc['description'],
          icon: IconData(doc['icon'], fontFamily: 'MaterialIcons'),
          stages: stagesData?.map((stage) => RoadmapStage(
            title: stage['title'],
            description: stage['description'],
            dueDate: (stage['dueDate'] as Timestamp?)?.toDate(),
          )).toList() ?? [],
        );
      }).toList();
    } catch (e) {
      throw Exception('Failed to load roadmaps: $e');
    }
  }

  // Add a new roadmap to Firestore
  Future<void> addRoadmap(String title, String description, IconData icon) async {
    try {
      await _firestore.collection('roadmaps').add({
        'title': title,
        'description': description,
        'icon': icon.codePoint, // Store the icon code point
        'stages': [],
      });
    } catch (e) {
      throw Exception('Failed to add roadmap: $e');
    }
  }

  // Add a stage to a specific roadmap
  Future<void> addStageToRoadmap(String roadmapTitle, RoadmapStage stage) async {
    try {
      final roadmapRef = _firestore.collection('roadmaps').where('title', isEqualTo: roadmapTitle);
      final snapshot = await roadmapRef.get();

      if (snapshot.docs.isNotEmpty) {
        final roadmapDoc = snapshot.docs.first;
        final stages = List.from(roadmapDoc['stages']);
        stages.add({
          'title': stage.title,
          'description': stage.description,
          'dueDate': stage.dueDate?.toIso8601String(),
        });

        await roadmapDoc.reference.update({'stages': stages});
      } else {
        throw Exception('Roadmap not found');
      }
    } catch (e) {
      throw Exception('Failed to add stage: $e');
    }
  }

  // Remove a stage from a specific roadmap
  Future<void> removeStageFromRoadmap(String roadmapTitle, int stageIndex) async {
    try {
      final roadmapRef = _firestore.collection('roadmaps').where('title', isEqualTo: roadmapTitle);
      final snapshot = await roadmapRef.get();

      if (snapshot.docs.isNotEmpty) {
        final roadmapDoc = snapshot.docs.first;
        final stages = List.from(roadmapDoc['stages']);
        stages.removeAt(stageIndex);

        await roadmapDoc.reference.update({'stages': stages});
      } else {
        throw Exception('Roadmap not found');
      }
    } catch (e) {
      throw Exception('Failed to remove stage: $e');
    }
  }

  // Update a stage in a specific roadmap
  Future<void> updateStageInRoadmap(String roadmapTitle, int stageIndex, RoadmapStage updatedStage) async {
    try {
      final roadmapRef = _firestore.collection('roadmaps').where('title', isEqualTo: roadmapTitle);
      final snapshot = await roadmapRef.get();

      if (snapshot.docs.isNotEmpty) {
        final roadmapDoc = snapshot.docs.first;
        final stages = List.from(roadmapDoc['stages']);
        stages[stageIndex] = {
          'title': updatedStage.title,
          'description': updatedStage.description,
          'dueDate': updatedStage.dueDate?.toIso8601String(),
        };

        await roadmapDoc.reference.update({'stages': stages});
      } else {
        throw Exception('Roadmap not found');
      }
    } catch (e) {
      throw Exception('Failed to update stage: $e');
    }
  }
}