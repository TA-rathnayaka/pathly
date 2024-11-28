class Milestone {
  String title;
  String description;
  String? link;
  String? imagePath;
  String? videoPath;

  Milestone({
    required this.title,
    required this.description,
    this.link,
    this.imagePath,
    this.videoPath,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'link': link,
      'imagePath': imagePath,
      'videoPath': videoPath,
    };
  }
}