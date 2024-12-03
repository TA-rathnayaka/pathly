import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pathly/models/roadmap.dart';
import 'package:pathly/models/roadmap_stage.dart';
import 'package:pathly/models/sub_task.dart';

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
              ?.map((stage) {
            // Extract subtasks from each stage
            var subtasksData = (stage['subtasks'] as List?)?.cast<Map<String, dynamic>>();

            // Map each stage and its subtasks
            return RoadmapStage(
              title: stage['title'] ?? 'Untitled Stage',
              description: stage['description'] ?? '',
              subtasks: subtasksData?.map((subtask) => Subtask(
                subtask: subtask['subtaskString'] ?? '', // Add subtaskString
                resourceUrl: subtask['resourceUrl'] ?? '', // Add resourceUrl
              )).toList() ?? [], // If no subtasks, default to an empty list
            );
          })
              .toList() ?? [],
          uid: doc['uid'] ?? '', // Add the UID field here
        );
      }).toList();
    } catch (e, stackTrace) {
      throw Exception('Failed to load roadmaps: $e\n$stackTrace');
    }
  }
  Future<List<Roadmap>> getRoadmapsByUid(String uid) async {
    try {
      // Query Firestore for roadmaps associated with the given UID
      final querySnapshot = await _firestore
          .collection('roadmaps')
          .where('uid', isEqualTo: uid)
          .get();

      // Convert Firestore documents into Roadmap objects
      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        var stagesData = (data['stages'] as List?)?.cast<Map<String, dynamic>>();

        return Roadmap(
          id: doc.id,
          title: data['title'] ?? 'Untitled',
          description: data['description'] ?? '',
          icon: IconData(
            data['icon'] is int ? data['icon'] : int.tryParse(data['icon'] ?? '0') ?? 0,
            fontFamily: 'MaterialIcons',
          ),
          imageUrl: data['imageUrl'] ?? '',
          uid: data['uid'] ?? '',
          stages: stagesData
              ?.map((stage) {
            // Extract the subtasks from each stage
            var subtasksData = (stage['subtasks'] as List?)?.cast<Map<String, dynamic>>();

            // Map each stage and its subtasks
            return RoadmapStage(
              title: stage['title'] ?? 'Untitled Stage',
              description: stage['description'] ?? '',
              subtasks: subtasksData?.map((subtask) => Subtask(
                subtask: subtask['subtaskString'] ?? '', // Add subtaskString
                resourceUrl: subtask['resourceUrl'] ?? '', // Add resourceUrl
              )).toList() ?? [], // If no subtasks, default to an empty list
            );
          })
              .toList() ?? [],
        );
      }).toList();
    } catch (e) {
      throw Exception('Failed to fetch roadmaps by UID: $e');
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
      String updatedUid, // Add UID to update
      ) async {
    try {
      final roadmapDocRef = _firestore.collection('roadmaps').doc(roadmapId);

      await roadmapDocRef.update({
        'title': updatedTitle,
        'description': updatedDescription,
        'icon': updatedIcon.codePoint,
        'imageUrl': updatedImageUrl,
        'uid': updatedUid, // Update the UID
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
          uid: roadmapDoc['uid'] ?? '',
          stages: stagesData
              ?.map((stage) {
            // Extract subtasks from each stage
            var subtasksData = (stage['subtasks'] as List?)?.cast<Map<String, dynamic>>();

            // Map each stage with its subtasks
            return RoadmapStage(
              title: stage['title'] ?? 'Untitled Stage',
              description: stage['description'] ?? '',
              subtasks: subtasksData?.map((subtask) {
                return Subtask(
                  subtask: subtask['subtaskString'] ?? '', // Extract subtaskString
                  resourceUrl: subtask['resourceUrl'] ?? '',   // Extract resourceUrl
                );
              }).toList() ?? [], // If no subtasks, default to an empty list
            );
          })
              .toList() ?? [],
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
      String imageUrl,  // Added imageUrl parameter
      String uid  // Added UID parameter
      ) async {
    try {
      final docRef = await _firestore.collection('roadmaps').add({
        'title': title,
        'description': description,
        'icon': icon.codePoint,
        'stages': [],
        'imageUrl': imageUrl,  // Save the imageUrl in Firestore
        'uid': uid,  // Save the UID of the user
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

        // Add the new stage with an empty list of subtasks by default
        stages.add({
          'title': stage.title,
          'description': stage.description,
          'subtasks': stage.subtasks.map((subtask) {
            return {
              'subtask': subtask.subtask,
              'resourceUrl': subtask.resourceUrl,
            };
          }).toList(),
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

        // Check if the stage index is valid
        if (stageIndex < stages.length) {
          // Update the stage at the given index
          stages[stageIndex] = {
            'title': updatedStage.title,
            'description': updatedStage.description,
            'subtasks': updatedStage.subtasks.map((subtask) {
              return {
                'subtask': subtask.subtask,
                'resourceUrl': subtask.resourceUrl,
              };
            }).toList(), // Update subtasks
          };

          // Update the roadmap document
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