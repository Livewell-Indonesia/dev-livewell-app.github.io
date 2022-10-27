import 'package:dartz/dartz.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/feature/daily_journal/data/repository/daily_journal_repo_impl.dart';

import '../../../../core/error/failures.dart';
import '../../../auth/data/model/register_model.dart';
import '../repository/daily_journal_repo.dart';

class PostDailyJournal extends UseCase<RegisterModel, DailyJournalParams> {
  late DailyJournalRepository repository;

  PostDailyJournal.getInstance() {
    repository = DailyJournalRepoImpl.getInstance();
  }

  @override
  Future<Either<Failure, RegisterModel>> call(DailyJournalParams params) async {
    return await repository.postDailyJournal(params);
  }
}

class DailyJournalParams {
  List<DailyJournals>? dailyJournal;

  DailyJournalParams({this.dailyJournal});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dailyJournal != null) {
      data['daily_journal'] = dailyJournal!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  DailyJournalParams.asParam(String name, String time) {
    dailyJournal = <DailyJournals>[];
    dailyJournal!.add(DailyJournals(name: name, time: time));
  }

  DailyJournalParams.asParams(String? breakfastTime, String? lunchTime,
      String? snackTime, String? dinnerTime) {
    dailyJournal = <DailyJournals>[];
    if (breakfastTime != null) {
      dailyJournal!.add(DailyJournals(name: 'Breakfast', time: breakfastTime));
    }
    if (lunchTime != null) {
      dailyJournal!.add(DailyJournals(name: 'Lunch', time: lunchTime));
    }
    if (snackTime != null) {
      dailyJournal!.add(DailyJournals(name: 'Snack', time: snackTime));
    }
    if (dinnerTime != null) {
      dailyJournal!.add(DailyJournals(name: 'Dinner', time: dinnerTime));
    }
  }
}

class DailyJournals {
  String? name;
  String? time;

  DailyJournals({this.name, this.time});

  DailyJournals.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['time'] = time;
    return data;
  }
}
