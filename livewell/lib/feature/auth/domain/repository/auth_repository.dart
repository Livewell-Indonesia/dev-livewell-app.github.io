import 'package:dartz/dartz.dart';
import 'package:livewell/feature/auth/domain/entity/register.dart';
import 'package:livewell/feature/auth/domain/usecase/post_change_password.dart';
import 'package:livewell/feature/auth/domain/usecase/post_register.dart';

import '../../../../core/error/failures.dart';
import '../entity/login.dart';
import '../usecase/post_forgot_password.dart';
import '../usecase/post_login.dart';

abstract class AuthRepository {
  Future<Either<Failure, Login>> login(ParamsLogin params);
  Future<Either<Failure, Register>> register(ParamsRegister params);
  Future<Either<Failure, Register>> forgotPassword(ParamsForgotPassword params);
  Future<Either<Failure, Register>> changePassword(ChangePasswordParams params);
}
