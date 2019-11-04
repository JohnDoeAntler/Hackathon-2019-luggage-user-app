import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:luggage_app_final/model/airplane_class.dart';
import 'package:luggage_app_final/model/airplane_classes.dart';
import 'package:luggage_app_final/model/luggage.dart';
import 'package:luggage_app_final/model/luggages.dart';
import './bloc.dart';
import 'package:http/http.dart' as http;

class FlightBloc extends Bloc<FlightEvent, FlightState> {
  @override
  FlightState get initialState => InitialFlightState();

  @override
  Stream<FlightState> mapEventToState(
    FlightEvent event,
  ) async* {
    if (event is GetFlight) {
      yield LoadingFlightState();
      final flightResponse = await http.get('http://119.246.37.218:3000/flights/${event.flightId}');

      final airplaneClassResponse = await http.get('http://119.246.37.218:3000/airplane_classes/${event.airplaneClassId}');
      final airplaneResponse = await http.get('http://119.246.37.218:3000/airplanes/${json.decode(flightResponse.body)['airplane_id']}');
      final usersResponse = await http.get('http://119.246.37.218:3000/users?flight_id=${event.flightId}');

      final airplaneClass = AirplaneClass.fromJson(json.decode(airplaneClassResponse.body));
      final airplaneClasses = AirplaneClasses.fromJson(json.decode(airplaneResponse.body)['airplane_classes']);
      final raw = json.decode(usersResponse.body).map<List<Luggage>>((u) => Luggages.fromJson(u['luggages']).luggages);
      final luggages = <Luggage>[];

      for (List<Luggage> ls in raw) {
        for (Luggage l in ls) {
          luggages.add(l);
        }
      }

      final assigned = luggages.map((luggage) => luggage.length * luggage.width * luggage.height).reduce((a, b) => a + b);

      yield LoadedFlightState(
        classOfTravel: airplaneClass.classOfTravel,
        totalAssigned: assigned,
        remainingSpace: airplaneClasses.airplaneClasses.map((a) => a.binAmount * a.binLength * a.binWidth * a.binHeight).reduce((a, b) => a + b) - assigned,
      );
    }
  }
}
