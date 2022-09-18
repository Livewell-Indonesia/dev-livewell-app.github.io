import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/parser_json.dart';
import '../entity/login.dart';
import '../usecase/post_login.dart';

abstract class AuthRepository {
  Future<Either<Failure, Login>> login(ParamsLogin params);
}
