import 'package:equatable/equatable.dart';

abstract class TicketEvent extends Equatable {
  TicketEvent([List props = const []]) : super(props);
}

class GetTicket extends TicketEvent {
  final int airplaneClassId;
  final int userId;

  GetTicket({
    this.airplaneClassId,
    this.userId
  }) : super([
    airplaneClassId,
    userId,
  ]);
}
