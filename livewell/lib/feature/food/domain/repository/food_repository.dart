import 'package:dartz/dartz.dart';
import 'package:livewell/feature/food/data/model/foods_model.dart';

import '../../../../core/error/failures.dart';

abstract class FoodRepository {
  Future<Either<Failure, FoodsModel>> getFoodHistory();
}
