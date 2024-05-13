import 'package:livewell/feature/streak/data/model/wellness_batch_data_model.dart';

class StreakEntity {
  final num hydrationScore;
  final num sleepScore;
  final num moodScore;
  final num nutritionScore;
  final num activityScore;
  final num totalScore;
  final bool isStreak;
  final DateTime recordAt;

  StreakEntity({
    required this.hydrationScore,
    required this.sleepScore,
    required this.moodScore,
    required this.nutritionScore,
    required this.activityScore,
    required this.totalScore,
    required this.isStreak,
    required this.recordAt,
  });

  factory StreakEntity.fromRemote(Datum datum) {
    return StreakEntity(
      hydrationScore: datum.hydrationScore ?? 0,
      sleepScore: datum.sleepScore ?? 0,
      moodScore: datum.moodScore ?? 0,
      nutritionScore: datum.nutritionScore ?? 0,
      activityScore: datum.activityScore ?? 0,
      totalScore: datum.totalScore ?? 0,
      isStreak: datum.isStreak ?? false,
      recordAt: datum.recordAt ?? DateTime.now(),
    );
  }
}
