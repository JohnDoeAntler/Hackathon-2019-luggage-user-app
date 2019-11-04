import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:luggage_app_final/model/user.dart';
import './bloc.dart';
import 'package:http/http.dart' as http;

class UserBloc extends Bloc<UserEvent, UserState> {
  @override
  UserState get initialState => InitialUserState();

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    // TODO: Add Logic
    if (event is GetUser) {
      yield LoadingUserState();
      try {
        final response = await http.get('http://119.246.37.218:3000/users?ticket_id=${event.ticketId}');
        yield LoadedUserState(User.fromJson(json.decode(response.body)[0]));
      } catch (e) {
        yield ErrorUserState(e.runtimeType.toString());
      }
    } else if (event is ResetUser) {
      yield InitialUserState();
    }
  }
}
