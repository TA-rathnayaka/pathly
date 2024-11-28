// // tech_path_service.dart
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:pathly/models/tech_path_model.dart';
//
// class TechPathService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   // Fetch TechPaths from Firestore
//   Future<List<TechPath>> fetchTechPaths() async {
//     try {
//       final snapshot = await _firestore.collection('tech_paths').get();
//       return snapshot.docs.map((doc) => TechPath.fromJson(doc.data())).toList();
//     } catch (e) {
//       print('Error fetching tech paths: $e');
//       throw Exception('Failed to load tech paths');
//     }
//   }
//
//   // Add a new TechPath to Firestore
//   Future<void> addTechPath(TechPath techPath) async {
//     try {
//       await _firestore.collection('tech_paths').add(techPath.toJson());
//     } catch (e) {
//       print('Error adding tech path: $e');
//       throw Exception('Failed to add tech path');
//     }
//   }
//
//   // Update an existing TechPath in Firestore
//   Future<void> updateTechPath(String docId, TechPath techPath) async {
//     try {
//       await _firestore.collection('tech_paths').doc(docId).update(techPath.toJson());
//     } catch (e) {
//       print('Error updating tech path: $e');
//       throw Exception('Failed to update tech path');
//     }
//   }
//
//   // Delete a TechPath from Firestore
//   Future<void> deleteTechPath(String docId) async {
//     try {
//       await _firestore.collection('tech_paths').doc(docId).delete();
//     } catch (e) {
//       print('Error deleting tech path: $e');
//       throw Exception('Failed to delete tech path');
//     }
//   }
// }
// // tech_path_service.dart
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:pathly/models/tech_path_model.dart';
//
// class TechPathService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   // Fetch TechPaths from Firestore
//   Future<List<TechPath>> fetchTechPaths() async {
//     try {
//       final snapshot = await _firestore.collection('tech_paths').get();
//       return snapshot.docs.map((doc) => TechPath.fromJson(doc.data())).toList();
//     } catch (e) {
//       print('Error fetching tech paths: $e');
//       throw Exception('Failed to load tech paths');
//     }
//   }
//
//   // Add a new TechPath to Firestore
//   Future<void> addTechPath(TechPath techPath) async {
//     try {
//       await _firestore.collection('tech_paths').add(techPath.toJson());
//     } catch (e) {
//       print('Error adding tech path: $e');
//       throw Exception('Failed to add tech path');
//     }
//   }
//
//   // Update an existing TechPath in Firestore
//   Future<void> updateTechPath(String docId, TechPath techPath) async {
//     try {
//       await _firestore.collection('tech_paths').doc(docId).update(techPath.toJson());
//     } catch (e) {
//       print('Error updating tech path: $e');
//       throw Exception('Failed to update tech path');
//     }
//   }
//
//   // Delete a TechPath from Firestore
//   Future<void> deleteTechPath(String docId) async {
//     try {
//       await _firestore.collection('tech_paths').doc(docId).delete();
//     } catch (e) {
//       print('Error deleting tech path: $e');
//       throw Exception('Failed to delete tech path');
//     }
//   }
// }


// tech_path_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pathly/models/tech_path.dart';



class TechPathService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch TechPaths from Firestore
  Future<List<TechPath>> fetchTechPaths() async {
    try {
      print("Fetching tech paths from Firestore...");
      final snapshot = await _firestore.collection('tech_paths').get();
      print("Fetched ${snapshot.docs.length} tech paths from Firestore.");
      return snapshot.docs.map((doc) {
        print("Document data: ${doc.data()}");
        return TechPath.fromJson(doc.data());
      }).toList();
    } catch (e) {
      print("Error fetching tech paths: $e");
      throw Exception("Failed to load tech paths: $e");
    }
  }

  // Add a new TechPath to Firestore
  Future<void> addTechPath(TechPath techPath) async {
    try {
      print("Adding new tech path: ${techPath.toJson()}");
      await _firestore.collection('tech_paths').add(techPath.toJson());
      print("Tech path added successfully.");
    } catch (e) {
      print("Error adding tech path: $e");
      throw Exception("Failed to add tech path: $e");
    }
  }

  // Update an existing TechPath in Firestore
  Future<void> updateTechPath(String docId, TechPath techPath) async {
    try {
      print("Updating tech path with ID: $docId");
      await _firestore.collection('tech_paths').doc(docId).update(techPath.toJson());
      print("Tech path updated successfully.");
    } catch (e) {
      print("Error updating tech path: $e");
      throw Exception("Failed to update tech path: $e");
    }
  }

  // Delete a TechPath from Firestore
  Future<void> deleteTechPath(String docId) async {
    try {
      print("Deleting tech path with ID: $docId");
      await _firestore.collection('tech_paths').doc(docId).delete();
      print("Tech path deleted successfully.");
    } catch (e) {
      print("Error deleting tech path: $e");
      throw Exception("Failed to delete tech path: $e");
    }
  }
}
