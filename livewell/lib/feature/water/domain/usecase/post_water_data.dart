import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/feature/auth/data/model/register_model.dart';
import 'package:livewell/feature/water/domain/repository/water_repository.dart';

import '../../data/repository/water_repository_impl.dart';

class PostWaterData extends UseCase<RegisterModel, PostWaterParams> {
  late WaterRepository repository;

  PostWaterData.instance() {
    repository = WaterRepositoryImpl.getInstance();
  }

  @override
  Future<Either<Failure, RegisterModel>> call(PostWaterParams params) {
    return repository.postWaterData(params);
  }
}

class PostWaterParams {
  int water;

  PostWaterParams({required this.water});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = 'WATER';
    data['value'] = water;
    data['date'] = DateFormat('yyyy-MM-dd').format(DateTime.now());
    return data;
  }
}
