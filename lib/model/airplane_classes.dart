import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'airplane_class.dart';

class AirplaneClasses extends Equatable{
  final List<AirplaneClass> airplaneClasses;

  AirplaneClasses({
    @required this.airplaneClasses,
  });

  factory AirplaneClasses.fromJson(json) {
    List<AirplaneClass> list = <AirplaneClass>[];

    for (int i = 0; i < json.length; i++) {
      list.add(
        AirplaneClass(
          id: json[i]['id'],
          airplaneId: json[i]['airplane_id'],
          classOfTravel: json[i]['cot'],
          seatAmount: json[i]['seat_amount'],
          binAmount: json[i]['bin_amount'],
          binLength: double.parse(json[i]['bin_length']),
          binWidth: double.parse(json[i]['bin_width']),
          binHeight: double.parse(json[i]['bin_height']),
          assignableSpacePercentage: double.parse(json[i]['assignable_space_percentage']),
          purchasableSpacePercentage: double.parse(json[i]['purchasable_space_percentage']),
        )
      );
    }

    return new AirplaneClasses(airplaneClasses: list);
  }
}
