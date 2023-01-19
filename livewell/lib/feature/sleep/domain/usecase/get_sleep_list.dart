import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/feature/sleep/data/model/sleep_activity_model.dart';
import 'package:livewell/feature/sleep/data/repository/sleep_repository_impl.dart';

import '../repository/sleep_repository.dart';

class GetSleepData extends UseCase<List<SleepActivityModel>, GetSleepParams> {
  late SleepRepository repository;
  GetSleepData.instance() {
    repository = SleepRepositoryImpl.getInstance();
  }
  @override
  Future<Either<Failure, List<SleepActivityModel>>> call(
      GetSleepParams params) async {
    return await repository.getSleepData(params);
  }
}

class GetSleepParams {
  List<String> type;
  DateTime dateFrom;
  DateTime dateTo;

  GetSleepParams({
    required this.type,
    required this.dateFrom,
    required this.dateTo,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['types'] = this.type;
    data['dateFrom'] = DateFormat('yyyy-MM-dd HH:mm:ss.sss').format(dateFrom);
    data['dateTo'] = DateFormat('yyyy-MM-dd HH:mm:ss.sss').format(dateTo);
    return data;
  }
}
