import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? message;
  final int? code;
  const Failure({this.message, this.code, List properties = const <dynamic>[]});
}

class ServerFailure extends Failure {
  const ServerFailure({String? message, int? code}) : super(message: message, code: code);
  @override
  List<Object?> get props => [message];
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({String? message}) : super(message: message);
  @override
  List<Object?> get props => [message];
}

class CacheFailure extends Failure {
  @override
  List<Object?> get props => [];
}
