import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:luggage_app_final/model/luggage.dart';

class Luggages extends Equatable{
  final List<Luggage> luggages;

  Luggages({
    @required this.luggages,
  });

  factory Luggages.fromJson(json) {
    List<Luggage> list = <Luggage>[];

    for (int i = 0; i < json.length; i++) {
      list.add(
        Luggage(
          id: json[i]['id'],
          userId: json[i]['user_id'],
          length: double.parse(json[i]['length']),
          width: double.parse(json[i]['width']),
          height: double.parse(json[i]['height']),
          imageUrl: json[i]['image_url'],
          spaceIndex: json[i]['space_index'],
          createdAt: DateTime.parse(json[i]['created_at']),
          updatedAt: DateTime.parse(json[i]['updated_at'])
        )
      );
    }

    return new Luggages(luggages: list);
  }
}
