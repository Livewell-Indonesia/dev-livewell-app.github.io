import 'package:livewell/feature/dashboard/data/model/feature_limit_model.dart';

class FeatureLimitEntity {
  List<FeatureLimit> featureLimits;

  FeatureLimitEntity({required this.featureLimits});

  factory FeatureLimitEntity.fromRemote(FeatureLimitModel model) {
    List<FeatureLimit> featureLimits = [];
    model.response?.forEach((element) {
      featureLimits.add(FeatureLimit(
          featureName: element.featureName!,
          currentUsage: element.currentUsage!,
          currentLimit: element.currentLimit!,
          defaultLimit: element.defaultLimit!,
          expiredAt: element.expiredAt!));
    });
    return FeatureLimitEntity(featureLimits: featureLimits);
  }
}

class FeatureLimit {
  String featureName;
  int currentUsage;
  int currentLimit;
  int defaultLimit;
  DateTime expiredAt;

  FeatureLimit(
      {required this.featureName,
      required this.currentUsage,
      required this.currentLimit,
      required this.defaultLimit,
      required this.expiredAt});
}
