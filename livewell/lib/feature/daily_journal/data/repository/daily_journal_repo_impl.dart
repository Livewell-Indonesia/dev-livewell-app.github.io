import 'package:dartz/dartz.dart';
import 'package:livewell/core/local_storage/shared_pref.dart';
import 'package:livewell/core/network/api_url.dart';
import 'package:livewell/core/network/network_module.dart';

import '../../../../core/error/failures.dart';
import '../../../auth/data/model/register_model.dart';
import '../../domain/repository/daily_journal_repo.dart';
import '../../domain/usecase/post_daily_journal.dart';

class DailyJournalRepoImpl extends NetworkModule
    implements DailyJournalRepository {
  DailyJournalRepoImpl._();

  static DailyJournalRepoImpl getInstance() => DailyJournalRepoImpl._();
  @override
  Future<Either<Failure, RegisterModel>> postDailyJournal(
      DailyJournalParams params) async {
    try {
      final response = await postMethod(Endpoint.dailyJournal,
          body: params.toJson(),
          headers: {authorization: await SharedPref.getToken()});
      final json = responseHandler(response);
      return Right(RegisterModel.fromJson(json));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
