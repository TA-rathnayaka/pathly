import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pathly/models/path.dart';
import 'package:pathly/models/milestone.dart';

class PathsService {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  // Fetch all paths from Firestore
  Future<List<Path>> getPaths() async {
    try {
      QuerySnapshot snapshot = await _fireStore.collection('paths').get();

      List<Path> paths = snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        List<Map<String, dynamic>> milestonesData = List<Map<String, dynamic>>.from(data['milestones'] ?? []);

        List<Milestone> milestones = milestonesData.map((milestoneData) {
          return Milestone(
            title: milestoneData['title'] as String,
            description: milestoneData['description'] as String,
            link: milestoneData['link'] as String?,
            imagePath: milestoneData['imagePath'] as String?,
            videoPath: milestoneData['videoPath'] as String?,
          );
        }).toList();

        return Path(
          name: data['name'] as String,
          description: data['description'] as String?,
          imageUrl: data['imageUrl'] as String?,
          milestones: milestones,
          createdOn: (data['createdOn'] as Timestamp).toDate(),
          modifiedOn: data['modifiedOn'] != null ? (data['modifiedOn'] as Timestamp).toDate() : null,
        );
      }).toList();

      return paths;
    } catch (e) {
      print("Error fetching paths: $e");
      return [];
    }
  }

  // Add a new path to Firestore
  Future<void> addPath(Path path) async {
    try {
      await _fireStore.collection('paths').add({
        'name': path.name,
        'description': path.description,
        'imageUrl': path.imageUrl,
        'milestones': path.milestones.map((milestone) {
          return {
            'title': milestone.title,
            'description': milestone.description,
            'link': milestone.link,
            'imagePath': milestone.imagePath,
            'videoPath': milestone.videoPath,
          };
        }).toList(),
        'createdOn': path.createdOn.toLocal().toString(),
        'modifiedOn': path.modifiedOn?.toLocal().toString(),
      });
    } catch (e) {
      print("Error adding path: $e");
    }
  }

  // Update an existing path in Firestore
  Future<void> updatePath(String pathId, Path updatedPath) async {
    try {
      await _fireStore.collection('paths').doc(pathId).update({
        'name': updatedPath.name,
        'description': updatedPath.description,
        'imageUrl': updatedPath.imageUrl,
        'milestones': updatedPath.milestones.map((milestone) {
          return {
            'title': milestone.title,
            'description': milestone.description,
            'link': milestone.link,
            'imagePath': milestone.imagePath,
            'videoPath': milestone.videoPath,
          };
        }).toList(),
        'createdOn': updatedPath.createdOn.toLocal().toString(),
        'modifiedOn': updatedPath.modifiedOn?.toLocal().toString(),
      });
    } catch (e) {
      print("Error updating path: $e");
    }
  }

  // Remove a path from Firestore
  Future<void> removePath(String pathId) async {
    try {
      await _fireStore.collection('paths').doc(pathId).delete();
    } catch (e) {
      print("Error removing path: $e");
    }
  }
}