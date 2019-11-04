import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:luggage_app_final/model/airplane_class.dart';
import 'package:luggage_app_final/model/luggages.dart';
import './bloc.dart';
import 'package:http/http.dart' as http;

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  @override
  TicketState get initialState => InitialTicketState();

  @override
  Stream<TicketState> mapEventToState(
    TicketEvent event,
  ) async* {
    // TODO: Add Logic
    if (event is GetTicket){
        yield LoadingTicketState();

        final airplaneClassResponse = await http.get('http://119.246.37.218:3000/airplane_classes/${event.airplaneClassId}');
        final luggagesResponse = await http.get('http://119.246.37.218:3000/luggages?user_id=${event.userId}');
        final purchaseLogsResponse = await http.get('http://119.246.37.218:3000/purchase_logs?user_id=${event.userId}');

        final airplaneClass = AirplaneClass.fromJson(json.decode(airplaneClassResponse.body));
        final luggages = Luggages.fromJson(json.decode(luggagesResponse.body)).luggages;
        final purchasedSpace = json.decode(purchaseLogsResponse.body).map((pl) => double.parse(pl['space_increasement'])).reduce((a, b) => a + b);

        final space = (airplaneClass.binAmount / airplaneClass.seatAmount) * airplaneClass.binLength * airplaneClass.binWidth * airplaneClass.binHeight;

        yield LoadedTicketState(
          assignableSpace: space * airplaneClass.assignableSpacePercentage,
          assignedSpace: luggages.map((l) => l.length * l.width * l.height).reduce((a, b) => a + b),
          purchasableSpace: space * airplaneClass.purchasableSpacePercentage,
          purchasedSpace: purchasedSpace,
        );
    }
  }
}
