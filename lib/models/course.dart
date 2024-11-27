class Course {
  final String id;
  final String title;
  final String description;
  final String instructor;
  final DateTime startDate;
  final DateTime? endDate;
  final String imageUrl;
  final int? duration;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.instructor,
    required this.startDate,
    this.endDate,
    required this.imageUrl,
    this.duration,
  });
}