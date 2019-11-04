import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class FlightState extends Equatable {
  FlightState([List props = const []]) : super(props);
}

class InitialFlightState extends FlightState {}

class LoadingFlightState extends FlightState {}

class LoadedFlightState extends FlightState {
  final String classOfTravel;
  final double totalAssigned;
  final double remainingSpace;

  LoadedFlightState({
    @required this.classOfTravel,
    @required this.totalAssigned,
    @required this.remainingSpace
  }) : super([
    classOfTravel,
    totalAssigned,
    remainingSpace
  ]);
}
