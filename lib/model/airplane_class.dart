import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class AirplaneClass extends Equatable {
  final int id;
  final int airplaneId;
  final String classOfTravel;
  final int seatAmount;
  final int binAmount;
  final double binLength;
  final double binWidth;
  final double binHeight;
  final double assignableSpacePercentage;
  final double purchasableSpacePercentage;

  AirplaneClass({
    @required this.id,
    @required this.airplaneId,
    @required this.classOfTravel,
    @required this.seatAmount,
    @required this.binAmount,
    @required this.binLength,
    @required this.binWidth,
    @required this.binHeight,
    @required this.assignableSpacePercentage,
    @required this.purchasableSpacePercentage
  });

  factory AirplaneClass.fromJson(json) {
    return AirplaneClass(
      id: json['id'],
      airplaneId: json['airplane_id'],
      classOfTravel: json['cot'],
      seatAmount: json['seat_amount'],
      binAmount: json['bin_amount'],
      binLength: double.parse(json['bin_length']),
      binWidth: double.parse(json['bin_width']),
      binHeight: double.parse(json['bin_height']),
      assignableSpacePercentage: double.parse(json['assignable_space_percentage']),
      purchasableSpacePercentage: double.parse(json['purchasable_space_percentage']),
    );
  }
}
