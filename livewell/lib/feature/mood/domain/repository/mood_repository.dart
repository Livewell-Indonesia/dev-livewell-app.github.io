import 'package:dartz/dartz.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/feature/mood/data/model/mood_detail_model.dart';
import 'package:livewell/feature/mood/data/model/mood_model.dart';

abstract class MoodRepository {
  Future<Either<Failure, MoodsModel>> getMoods(int value);
  Future<Either<Failure, MoodDetail>> getSingleMood(String date);
}
