import 'package:equatable/equatable.dart';
import 'package:luggage_app_final/model/user.dart';

abstract class UserState extends Equatable {
  UserState([List props = const[]]) : super(props);
}

class InitialUserState extends UserState {}

class LoadingUserState extends UserState {}

class LoadedUserState extends UserState {
  final User user;

  LoadedUserState(this.user) : super([user]);
}

class ErrorUserState extends UserState {
  final String errorType;

  ErrorUserState(this.errorType) : super([errorType]);
}
