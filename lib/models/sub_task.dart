class Subtask {
  final String resourceUrl;
  final String subtask;

  // Constructor to initialize the Subtask object
  Subtask({
    required this.resourceUrl,
    required this.subtask,
  });

  // Factory method to create a Subtask from JSON (e.g., from Firestore or API)
  factory Subtask.fromJson(Map<String, dynamic> json) {
    return Subtask(
      resourceUrl: json['resourceUrl'] ?? '',
      subtask: json['subtask'] ?? '',
    );
  }

  // Method to convert Subtask object to JSON
  Map<String, dynamic> toJson() {
    return {
      'resourceUrl': resourceUrl,
      'subtask': subtask,
    };
  }
}