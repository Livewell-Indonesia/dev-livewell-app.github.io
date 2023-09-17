import 'package:dartz/dartz.dart';
import 'package:livewell/core/network/api_url.dart';
import 'package:livewell/core/network/network_module.dart';
import 'package:livewell/feature/questionnaire/domain/repository/questionnaire_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/local_storage/shared_pref.dart';
import '../../../auth/data/model/register_model.dart';
import '../../domain/usecase/post_questionnaire.dart';

class QuestionnaireRepositoryImpl with NetworkModule
    implements QuestionnaireRepository {
  QuestionnaireRepositoryImpl._();

  static QuestionnaireRepositoryImpl getInstance() =>
      QuestionnaireRepositoryImpl._();

  @override
  Future<Either<Failure, RegisterModel>> postQuestionnaire(
      QuestionnaireParams params) async {
    try {
      final response = await postMethod(Endpoint.questionnaire,
          body: params.toJson(),
          headers: {authorization: await SharedPref.getToken()});
      final json = responseHandler(response);
      final data = RegisterModel.fromJson(json);
      return Right(data);
    } catch (ex) {
      return const Left(ServerFailure());
    }
  }
}
