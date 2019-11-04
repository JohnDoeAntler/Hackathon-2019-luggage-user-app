import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  UserEvent([List props = const []]) : super(props);
}

class GetUser extends UserEvent {
  final String ticketId;

  GetUser(this.ticketId) : super([ticketId]);
}

class ResetUser extends UserEvent {}