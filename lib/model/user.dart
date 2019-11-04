import 'package:equatable/equatable.dart';
import 'package:luggage_app_final/model/luggages.dart';
import 'package:meta/meta.dart';

class User extends Equatable {
  final int id;
  final int airplaneClassId;
  final int flightId;
  final String ticketId;
  final int seatIndex;

  final Luggages luggages;

  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    @required this.id,
    @required this.airplaneClassId,
    @required this.flightId,
    @required this.ticketId,
    @required this.seatIndex,
    @required this.createdAt,
    @required this.updatedAt,
    @required this.luggages,
  });

  factory User.fromJson(json) {
    return User(
      id: json['id'],
      airplaneClassId: json['airplane_class_id'],
      flightId: json['flight_id'],
      ticketId: json['ticket_id'],
      seatIndex: json['seat_index'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      luggages: Luggages.fromJson(json['luggages']),
    );
  }
}
