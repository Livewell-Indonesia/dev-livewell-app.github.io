import 'package:dartz/dartz.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/feature/food/data/model/foods_model.dart';
import 'package:livewell/feature/nutrico/data/model/nutrico_asset_model.dart';
import 'package:livewell/feature/nutrico/domain/usecase/post_nutrico.dart';

abstract class NutricoRepository {
  Future<Either<Failure, Foods>> getNutrico(PostNutricoParams params);
  Future<Either<Failure, NutricoAsset>> getNutricoAsset();
}
