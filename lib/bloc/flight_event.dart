import 'package:equatable/equatable.dart';

abstract class FlightEvent extends Equatable {
  FlightEvent([List props = const []]) : super(props);
}

class GetFlight extends FlightEvent {
  final flightId;
  final airplaneClassId;

  GetFlight({
    this.flightId,
    this.airplaneClassId
  }) : super([
    flightId,
    airplaneClassId
  ]);
}
