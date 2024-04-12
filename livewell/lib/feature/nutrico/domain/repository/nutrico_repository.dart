import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/feature/food/data/model/foods_model.dart';
import 'package:livewell/feature/nutrico/data/model/nutrico_asset_model.dart';
import 'package:livewell/feature/nutrico/data/model/nutrico_plus_asset_loading_model.dart';
import 'package:livewell/feature/nutrico/data/model/nutrico_search_by_image_model.dart';
import 'package:livewell/feature/nutrico/domain/usecase/post_nutrico.dart';

abstract class NutricoRepository {
  Future<Either<Failure, Foods>> getNutrico(PostNutricoParams params);
  Future<Either<Failure, NutricoAsset>> getNutricoAsset();
  Future<Either<Failure, NutricoSearchByImageModel>> searchByImage(File file);
  Future<Either<Failure, List<NutricoPlusAssetLoadingModel>>> getNutricoLoadingAsset();
}
