import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:luggage_app_final/model/luggages.dart';
import './bloc.dart';
import 'package:http/http.dart' as http;

class LuggagesBloc extends Bloc<LuggagesEvent, LuggagesState> {
  @override
  LuggagesState get initialState => InitialLuggagesState();

  @override
  Stream<LuggagesState> mapEventToState(
    LuggagesEvent event,
  ) async* {
    if (event is GetLuggages){
        yield LoadingLuggagesState();
        final response = await http.get('http://119.246.37.218:3000/luggages?user_id=${event.userId}');
        yield LoadedLuggagesState(Luggages.fromJson(json.decode(response.body)).luggages);
    }
  }
}
