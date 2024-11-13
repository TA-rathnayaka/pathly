import 'dart:core';

class Achievement {
  String achievementId;
  String title;
  String description;
  DateTime? dateEarned;

  Achievement(this.achievementId, this.title, this.description);

  void unlockAchievement() {
    if (dateEarned == null) {
      dateEarned = DateTime.now();
      print('Achievement "$title" unlocked!');
    } else {
      print(
          'Achievement "$title" was already unlocked on ${dateEarned!.toIso8601String()}');
    }
  }

  Map<String, dynamic> getAchievementDetails() {
    return {
      'id': achievementId,
      'title': title,
      'description': description,
      'dateEarned': dateEarned?.toIso8601String() ?? 'Not yet earned',
    };
  }
}
