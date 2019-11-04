import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Luggage extends Equatable {
  final int id;
  final int userId;
  final double length;
  final double width;
  final double height;
  final String imageUrl;
  final int spaceIndex;

  final DateTime createdAt;
  final DateTime updatedAt;

  Luggage({
    @required this.id,
    @required this.userId,
    @required this.length,
    @required this.width,
    @required this.height,
    @required this.imageUrl,
    @required this.spaceIndex,
    @required this.createdAt,
    @required this.updatedAt
  });

  factory Luggage.fromJson(json) {
    return Luggage(
      id: json['id'],
      userId: json['user_id'],
      length: json['length'],
      width: json['width'],
      height: json['height'],
      imageUrl: json['image_url'],
      spaceIndex: json['space_index'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at'])
    );
  }
}
