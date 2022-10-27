import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';
import 'package:livewell/core/base/usecase.dart';
import 'package:livewell/core/error/failures.dart';
import 'package:livewell/feature/diary/data/repository/diary_repository_impl.dart';

import '../entity/user_meal_history_model.dart';
import '../repository/diary_repository.dart';

class GetUserMealHistory
    extends UseCase<UserMealHistoryModel, UserMealHistoryParams> {
  late DiaryRepostiory repository;

  GetUserMealHistory.instance() {
    repository = DiaryRepositoryImpl.getInstance();
  }
  @override
  Future<Either<Failure, UserMealHistoryModel>> call(
      UserMealHistoryParams params) async {
    return await repository.getUserMealHistory(params);
  }
}

class UserMealHistoryParams {
  Filter? filter;
  UserMealHistoryParams({this.filter});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (filter != null) {
      data['filter'] = filter!.toJson();
    }
    return data;
  }
}

class Filter {
  DateTime? startDate;
  DateTime? endDate;

  Filter({this.startDate, this.endDate});

  Filter.fromJson(Map<String, dynamic> json) {
    startDate = json['startDate'];
    endDate = json['endDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['start_date'] = DateFormat('yyyy-MM-dd HH:mm:ss').format(endDate!);
    data['end_date'] = DateFormat('yyyy-MM-dd HH:mm:ss').format(startDate!);
    return data;
  }
}
