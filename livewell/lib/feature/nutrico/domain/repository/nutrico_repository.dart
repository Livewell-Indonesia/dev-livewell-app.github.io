import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/feature/food/data/model/foods_model.dart';
import 'package:livewell/feature/nutrico/data/model/nutrico_asset_model.dart';
import 'package:livewell/feature/nutrico/data/model/nutrico_food_model.dart';
import 'package:livewell/feature/nutrico/data/model/nutrico_plus_asset_loading_model.dart';
import 'package:livewell/feature/nutrico/data/model/nutrico_plus_tutorial_asset_model.dart';
import 'package:livewell/feature/nutrico/domain/usecase/post_nutrico.dart';

abstract class NutricoRepository {
  Future<Either<Failure, Foods>> getNutrico(PostNutricoParams params);
  Future<Either<Failure, Foods>> getNutricoV2(PostNutricoParams params);
  Future<Either<Failure, NutricoAsset>> getNutricoAsset();
  Future<Either<Failure, NutricoFoodModel>> searchByImage(File file);
  Future<Either<Failure, List<NutricoPlusAssetLoadingModel>>> getNutricoLoadingAsset();
  Future<Either<Failure, NutricoPlusTutorialAssetModel>> getNutricoPlusTutorialAsset();
  Future<Either<Failure, NutricoFoodModel>> searchByImageWeb(List<int> imageBytes);
}
