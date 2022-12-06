import 'package:dartz/dartz.dart';
import 'package:livewell/feature/auth/data/model/register_model.dart';
import 'package:livewell/feature/update_weight/data/repository/update_weight_repository_impl.dart';

import '../../../../core/base/usecase.dart';
import '../../../../core/error/failures.dart';
import '../repository/update_weight_repository.dart';

class UpdateUserWeight extends UseCase<RegisterModel, UpdateWeightParams> {
  late UpdateWeightRepository repository;

  UpdateUserWeight.instance() {
    repository = UpdateWeightRepositoryImpl.getInstance();
  }
  @override
  Future<Either<Failure, RegisterModel>> call(UpdateWeightParams params) async {
    return await repository.updateWeight(params);
  }
}

class UpdateWeightParams {
  num weight;

  UpdateWeightParams({required this.weight});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['weight'] = weight;
    return data;
  }
}
