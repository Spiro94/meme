import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  List<Object> get props => [];
}

//General Failures
class ServerFailure extends Failure {}
