class RoadmapStage {
  final String title;
  final String description;
  final String? resourceUrl; // Resource URL remains

  RoadmapStage({
    required this.title,
    required this.description,
    this.resourceUrl, // Resource URL is optional
  });
}