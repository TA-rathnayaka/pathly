import 'package:flutter/foundation.dart';
import 'package:pathly/models/course.dart';

class CourseProvider extends ChangeNotifier {
  final List<Course> _courses = [];

  List<Course> get courses => List.unmodifiable(_courses);

  // Add a new course
  void addCourse(Course course) {
    _courses.add(course);
    notifyListeners();
  }

  // Update an existing course by id
  void updateCourse(String id, Course updatedCourse) {
    final index = _courses.indexWhere((course) => course.id == id);
    if (index != -1) {
      _courses[index] = updatedCourse;
      notifyListeners();
    }
  }

  // Remove a course by id
  void removeCourse(String id) {
    _courses.removeWhere((course) => course.id == id);
    notifyListeners();
  }

  // Get a course by id
  Course? getCourseById(String id) {
    return _courses.firstWhere(
          (course) => course.id == id,
      orElse: () => Course(
        id: '',
        title: '',
        description: '',
        instructor: '',
        startDate: DateTime.now(),
        imageUrl: '',
        duration: null,
      ),
    );
  }
}