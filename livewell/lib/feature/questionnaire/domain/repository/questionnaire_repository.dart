import 'package:dartz/dartz.dart';
import 'package:livewell/feature/auth/data/model/register_model.dart';

import '../../../../core/error/failures.dart';
import '../usecase/post_questionnaire.dart';

abstract class QuestionnaireRepository {
  Future<Either<Failure, RegisterModel>> postQuestionnaire(
      QuestionnaireParams params);
}
