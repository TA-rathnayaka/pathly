import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pathly/models/course.dart';

class CourseService {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<List<Course>> getCourses() async {
    try {
      QuerySnapshot snapshot = await _fireStore.collection('courses').get();
      List<Course> courses = snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        Timestamp? startDateTimestamp = data['startDate'] as Timestamp?;
        DateTime startDate = startDateTimestamp?.toDate() ?? DateTime.now(); // Default to current date if null
        Timestamp? endDateTimestamp = data['endDate'] as Timestamp?;
        DateTime? endDate = endDateTimestamp?.toDate();
        int? duration = data['duration'] != null ? data['duration'] as int : null;
        String imageUrl = data['imageUrl'] ?? '';

        return Course(
          id: doc.id, // Ensure you use the document ID as a unique identifier
          title: data['title'] as String,
          description: data['description'] as String,
          instructor: data['instructor'] as String,
          startDate: startDate,
          endDate: endDate,
          imageUrl: imageUrl,
          duration: duration,
        );
      }).toList();

      return courses;
    } catch (e) {
      print("Error fetching courses: $e");
      return [];
    }
  }
}