import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/feature/nutrico/data/model/nutrico_search_by_image_model.dart';
import 'package:livewell/feature/nutrico/data/repository/nutrico_repository_impl.dart';
import 'package:livewell/feature/nutrico/domain/repository/nutrico_repository.dart';

class SearchByImage extends UseCase<NutricoSearchByImageModel, File> {
  late NutricoRepository repository;

  SearchByImage.instance() {
    repository = NutricoRepositoryImpl.getInstance();
  }
  @override
  Future<Either<Failure, NutricoSearchByImageModel>> call(File params) async {
    return await repository.searchByImage(params);
  }
}
