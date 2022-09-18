import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? message;
  const Failure({this.message, List properties = const <dynamic>[]});
}

class ServerFailure extends Failure {
  const ServerFailure({String? message}) : super(message: message);
  @override
  List<Object?> get props => [message];
}

class CacheFailure extends Failure {
  @override
  List<Object?> get props => [];
}
