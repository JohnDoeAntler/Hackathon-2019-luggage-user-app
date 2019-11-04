import 'package:equatable/equatable.dart';
import 'package:luggage_app_final/model/luggage.dart';

abstract class LuggagesState extends Equatable {
  LuggagesState([List props = const[]]) : super(props);
}

class InitialLuggagesState extends LuggagesState {}

class LoadingLuggagesState extends LuggagesState {}

class LoadedLuggagesState extends LuggagesState {
  final List<Luggage> luggages;

  LoadedLuggagesState(this.luggages) : super([luggages]);
}
