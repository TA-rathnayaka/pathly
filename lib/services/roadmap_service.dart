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
        // Extract the list of stages, ensuring it's the correct type
        var stagesData = (doc['stages'] as List?)?.cast<Map<String, dynamic>>();

        return Roadmap(
          id: doc.id,
          title: doc['title'] ?? 'Untitled',
          description: doc['description'] ?? '',
          icon: IconData(
            doc['icon'] is int ? doc['icon'] : int.tryParse(doc['icon'] ?? '0') ?? 0,
            fontFamily: 'MaterialIcons',
          ),
          imageUrl: doc['imageUrl'] ?? '',
          stages: stagesData
              ?.map((stage) => RoadmapStage(
            title: stage['title'] ?? 'Untitled Stage',
            description: stage['description'] ?? '',
            resourceUrl: stage['resourceUrl'] ?? '', // Add resourceUrl
          ))
              .toList() ??
              [],
        );
      }).toList();
    } catch (e, stackTrace) {
      throw Exception('Failed to load roadmaps: $e\n$stackTrace');
    }
  }



  Future<void> deleteRoadmap(String roadmapId) async {
    try {
      final roadmapDocRef = _firestore.collection('roadmaps').doc(roadmapId);

      // Delete the roadmap document from Firestore
      await roadmapDocRef.delete();
    } catch (e) {
      throw Exception('Failed to delete roadmap: $e');
    }
  }


  Future<void> updateRoadmap(
      String roadmapId,
      String updatedTitle,
      String updatedDescription,
      IconData updatedIcon,
      String updatedImageUrl,
      ) async {
    try {
      final roadmapDocRef = _firestore.collection('roadmaps').doc(roadmapId);

      await roadmapDocRef.update({
        'title': updatedTitle,
        'description': updatedDescription,
        'icon': updatedIcon.codePoint,
        'imageUrl': updatedImageUrl,
      });
    } catch (e) {
      throw Exception('Failed to update roadmap in Firestore: $e');
    }
  }



  // Fetch a specific roadmap by its ID
  Future<Roadmap> getRoadmapById(String roadmapId) async {
    try {
      final roadmapDocRef = _firestore.collection('roadmaps').doc(roadmapId);
      final roadmapDoc = await roadmapDocRef.get();

      if (roadmapDoc.exists) {
        var stagesData = (roadmapDoc['stages'] as List?)?.cast<Map<String, dynamic>>();

        return Roadmap(
          id: roadmapDoc.id,
          title: roadmapDoc['title'] ?? 'Untitled',
          description: roadmapDoc['description'] ?? '',
          icon: IconData(
            roadmapDoc['icon'] is int ? roadmapDoc['icon'] : int.tryParse(roadmapDoc['icon'] ?? '0') ?? 0,
            fontFamily: 'MaterialIcons',
          ),
          imageUrl: roadmapDoc['imageUrl'] ?? '',
          stages: stagesData
              ?.map((stage) => RoadmapStage(
            title: stage['title'] ?? 'Untitled Stage',
            description: stage['description'] ?? '',
            resourceUrl: stage['resourceUrl'] ?? '', // Add resourceUrl
          ))
              .toList() ??
              [],
        );
      } else {
        throw Exception('Roadmap with ID $roadmapId not found');
      }
    } catch (e) {
      throw Exception('Failed to load roadmap by ID: $e');
    }
  }

  // Add a new roadmap to Firestore
  Future<String> addRoadmap(
      String title,
      String description,
      IconData icon,
      String imageUrl  // Added imageUrl parameter
      ) async {
    try {
      final docRef = await _firestore.collection('roadmaps').add({
        'title': title,
        'description': description,
        'icon': icon.codePoint,
        'stages': [],
        'imageUrl': imageUrl,  // Save the imageUrl in Firestore
      });

      return docRef.id;
    } catch (e) {
      throw Exception('Failed to add roadmap: $e');
    }
  }

  // Add a stage to a specific roadmap using the roadmapId
  Future<void> addStageToRoadmap(String roadmapId, RoadmapStage stage) async {
    try {
      final roadmapDocRef = _firestore.collection('roadmaps').doc(roadmapId);
      final roadmapDoc = await roadmapDocRef.get();

      if (roadmapDoc.exists) {
        final stages = List<Map<String, dynamic>>.from(roadmapDoc['stages']);
        stages.add({
          'title': stage.title,
          'description': stage.description,
          'resourceUrl': stage.resourceUrl, // Add resourceUrl
        });

        await roadmapDocRef.update({'stages': stages});
      } else {
        throw Exception('Roadmap not found');
      }
    } catch (e) {
      throw Exception('Failed to add stage: $e');
    }
  }

  // Remove a stage from a specific roadmap using the roadmapId
  Future<void> removeStageFromRoadmap(String roadmapId, int stageIndex) async {
    try {
      final roadmapDocRef = _firestore.collection('roadmaps').doc(roadmapId);
      final roadmapDoc = await roadmapDocRef.get();

      if (roadmapDoc.exists) {
        final stages = List<Map<String, dynamic>>.from(roadmapDoc['stages']);
        if (stageIndex < stages.length) {
          stages.removeAt(stageIndex);
          await roadmapDocRef.update({'stages': stages});
        } else {
          throw Exception('Stage index out of bounds');
        }
      } else {
        throw Exception('Roadmap not found');
      }
    } catch (e) {
      throw Exception('Failed to remove stage: $e');
    }
  }

  // Update a stage in a specific roadmap using the roadmapId
  Future<void> updateStageInRoadmap(
      String roadmapId, int stageIndex, RoadmapStage updatedStage) async {
    try {
      final roadmapDocRef = _firestore.collection('roadmaps').doc(roadmapId);
      final roadmapDoc = await roadmapDocRef.get();

      if (roadmapDoc.exists) {
        final stages = List<Map<String, dynamic>>.from(roadmapDoc['stages']);
        if (stageIndex < stages.length) {
          stages[stageIndex] = {
            'title': updatedStage.title,
            'description': updatedStage.description,
            'resourceUrl': updatedStage.resourceUrl, // Update resourceUrl
          };

          await roadmapDocRef.update({'stages': stages});
        } else {
          throw Exception('Stage index out of bounds');
        }
      } else {
        throw Exception('Roadmap not found');
      }
    } catch (e) {
      throw Exception('Failed to update stage: $e');
    }
  }

  Future<List<String>> getEnrolledRoadmapIdsForUser(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('enrolledRoadmaps')
          .get();
      return snapshot.docs.map((doc) => doc.id).toList();
    } catch (e) {
      throw Exception('Failed to fetch enrolled roadmap IDs: $e');
    }
  }

  // Enroll a user in a roadmap
  Future<void> enrollUserInRoadmap(String userId, String roadmapId) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('enrolledRoadmaps')
          .doc(roadmapId)
          .set({});
    } catch (e) {
      throw Exception('Failed to enroll user in roadmap: $e');
    }
  }

  // Remove a user from a roadmap
  Future<void> removeUserFromRoadmap(String userId, String roadmapId) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('enrolledRoadmaps')
          .doc(roadmapId)
          .delete();
    } catch (e) {
      throw Exception('Failed to remove user from roadmap: $e');
    }
  }
}