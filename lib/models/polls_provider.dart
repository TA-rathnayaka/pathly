import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:pathly/models/course.dart';
import 'package:pathly/services/course_service.dart';

class CourseProvider extends ChangeNotifier {
  final CourseService courseService = CourseService();
  List<Course> _courses = [];

  CourseProvider() {
    fetchCourses();
  }

  UnmodifiableListView<Course> get courses => UnmodifiableListView(_courses);

  Future<void> fetchCourses() async {
    _courses = await courseService.getCourses();
    notifyListeners();
  }


  void addCourse(Course course) {
    _courses.add(course);
    notifyListeners();
  }


  void removeCourse(int index) {
    if (index >= 0 && index < _courses.length) {
      _courses.removeAt(index);
      notifyListeners();
    }
  }


  void updateCourse(int index, Course updatedCourse) {
    if (index >= 0 && index < _courses.length) {
      _courses[index] = updatedCourse;
      notifyListeners();
    }
  }


  // Course? getCourseById(String id) {
  //   return _courses.firstWhere(
  //         (course) => course.id == id,
  //     orElse: () => null,
  //   );
  // }
}