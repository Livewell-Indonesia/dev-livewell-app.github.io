import 'package:dartz/dartz.dart';
import 'package:livewell/core/local_storage/shared_pref.dart';
import 'package:livewell/core/network/network_module.dart';
import 'package:livewell/feature/food/domain/repository/food_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/log.dart';
import '../../../../core/network/api_url.dart';
import '../model/foods_model.dart';

class FoodRepositoryImpl extends NetworkModule implements FoodRepository {
  FoodRepositoryImpl._();

  static FoodRepositoryImpl getInstance() => FoodRepositoryImpl._();

  @override
  Future<Either<Failure, FoodsModel>> getFoodHistory() async {
    try {
      final response = await postMethod(Endpoint.foods, body: {
        "name": ""
      }, headers: {
        authorization:
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NjMxNzE4MjgsImlhdCI6MTY2MzE2ODIyOCwiaXNzIjoibGl2ZXdlbGwiLCJzdWIiOiIwZTE0YTgyNS1hNDU2LTRjZjctOTkyOS1kYTZmMzIxMTYzNzIifQ.IcVBZohXG0wm6884As54bIQ-Sa2LJ3EXNue55hUidd4"
      });
      final json = responseHandler(response);
      // final json = responseHandler(response);
      final data = FoodsModel.fromJson(json);
      return Right(data);
    } catch (ex) {
      Log.error(ex);
      return Left(ServerFailure(message: ex.toString()));
    }
  }
}
