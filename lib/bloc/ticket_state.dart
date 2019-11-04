import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class TicketState extends Equatable {
  TicketState([List props = const []]) : super(props);
}

class InitialTicketState extends TicketState {}

class LoadingTicketState extends TicketState {}

class LoadedTicketState extends TicketState {
  final double assignedSpace;
  final double assignableSpace;
  final double purchasedSpace;
  final double purchasableSpace;

  LoadedTicketState({
    @required this.assignedSpace,
    @required this.assignableSpace,
    @required this.purchasedSpace,
    @required this.purchasableSpace
  }) : super([
    assignedSpace,
    assignableSpace,
    purchasedSpace,
    purchasableSpace,
  ]);
}
