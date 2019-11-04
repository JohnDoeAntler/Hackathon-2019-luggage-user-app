import 'package:equatable/equatable.dart';

abstract class LuggagesEvent extends Equatable {
  LuggagesEvent([List props = const[]]) : super(props);
}

class GetLuggages extends LuggagesEvent {
  final int userId;

  GetLuggages(this.userId) : super([userId]);
}