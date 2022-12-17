import 'package:dartz/dartz.dart';
import 'package:health/health.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/feature/auth/data/model/register_model.dart';
import 'package:livewell/feature/exercise/domain/repository/exercise_repository.dart';

import '../../data/repository/exercise_repository_impl.dart';

class PostExerciseData extends UseCase<RegisterModel, PostExerciseParams> {
  late ExerciseRepository repository;
  PostExerciseData.instance() {
    repository = ExerciseRepositoryImpl.getInstance();
  }
  @override
  Future<Either<Failure, RegisterModel>> call(PostExerciseParams params) async {
    return await repository.postExerciseData(params);
  }
}

class PostExerciseParams {
  List<Activities>? activities;

  PostExerciseParams({this.activities});

  PostExerciseParams.fromJson(Map<String, dynamic> json) {
    if (json['activities'] != null) {
      activities = <Activities>[];
      json['activities'].forEach((v) {
        activities!.add(new Activities.fromJson(v));
      });
    }
  }

  PostExerciseParams.fromHealth(List<HealthDataPoint> data) {
    activities = data.map((e) => Activities.fromHealth(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.activities != null) {
      data['activities'] = this.activities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Activities {
  double? value;
  String? type;
  String? unit;
  String? dateFrom;
  String? dateTo;
  String? platformType;
  String? deviceId;
  String? sourceId;
  String? sourceName;

  Activities(
      {this.value,
      this.type,
      this.unit,
      this.dateFrom,
      this.dateTo,
      this.platformType,
      this.deviceId,
      this.sourceId,
      this.sourceName});

  Activities.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    type = json['type'];
    unit = json['unit'];
    dateFrom = json['date_from'];
    dateTo = json['date_to'];
    platformType = json['platform_type'];
    deviceId = json['device_id'];
    sourceId = json['source_id'];
    sourceName = json['source_name'];
  }

  Activities.fromHealth(HealthDataPoint data) {
    value = double.tryParse(data.value.toString()) ?? 0.0;
    type = data.type.name;
    unit = data.unitString;
    dateFrom = data.dateFrom.toIso8601String();
    dateTo = data.dateTo.toIso8601String();
    platformType = data.platform.toString();
    deviceId = data.deviceId.toString();
    sourceId = data.sourceId.toString();
    sourceName = data.sourceName.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['type'] = this.type;
    data['unit'] = this.unit;
    data['date_from'] = this.dateFrom;
    data['date_to'] = this.dateTo;
    data['platform_type'] = this.platformType;
    data['device_id'] = this.deviceId;
    data['source_id'] = this.sourceId;
    data['source_name'] = this.sourceName;
    return data;
  }
}
