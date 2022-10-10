import 'package:dartz/dartz.dart';
import 'package:livewell/feature/auth/data/model/register_model.dart';
import 'package:livewell/feature/daily_journal/domain/usecase/post_daily_journal.dart';

import '../../../../core/error/failures.dart';

abstract class DailyJournalRepository {
  Future<Either<Failure, RegisterModel>> postDailyJournal(
      DailyJournalParams params);
}
