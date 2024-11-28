import 'package:pathly/models/milestone.dart';

class Path {
  String name;
  String? description;
  String? imageUrl;
  List<Milestone> milestones;
  DateTime createdOn;
  DateTime? modifiedOn;

  Path({
    required this.name,
    this.description,
    this.imageUrl,
    required this.milestones,
    DateTime? createdOn,
    this.modifiedOn,  // Optional: This is the modifiedOn field.
  }) : createdOn = createdOn ?? DateTime.now(); // Set to current time if not provided.

  void addMilestone(Milestone milestone) {
    milestones.add(milestone);
    modifiedOn = DateTime.now();
  }

  void removeMilestone(String title) {
    milestones.removeWhere((milestone) => milestone.title == title);
    modifiedOn = DateTime.now();
  }

  Map<String, dynamic> getPathDetails() {
    return {
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'milestones': milestones.map((milestone) => milestone.toMap()).toList(),
      'createdOn': createdOn.toLocal().toString(),
      'modifiedOn': modifiedOn?.toLocal().toString(),
    };
  }
}