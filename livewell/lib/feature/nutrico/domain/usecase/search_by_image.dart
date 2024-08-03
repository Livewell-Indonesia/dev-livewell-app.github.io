import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/feature/nutrico/data/model/nutrico_food_model.dart';

import 'package:livewell/feature/nutrico/data/repository/nutrico_repository_impl.dart';
import 'package:livewell/feature/nutrico/domain/repository/nutrico_repository.dart';

class SearchByImage extends UseCase<NutricoFoodModel, File> {
  late NutricoRepository repository;

  SearchByImage.instance() {
    repository = NutricoRepositoryImpl.getInstance();
  }
  @override
  Future<Either<Failure, NutricoFoodModel>> call(File params) async {
    return await repository.searchByImage(params);
  }
}
