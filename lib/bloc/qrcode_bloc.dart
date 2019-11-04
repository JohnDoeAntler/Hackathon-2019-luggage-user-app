import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import 'package:http/http.dart' as http;

class QrcodeBloc extends Bloc<QrcodeEvent, QrcodeState> {
  @override
  QrcodeState get initialState => InitialQrcodeState();

  @override
  Stream<QrcodeState> mapEventToState(
    QrcodeEvent event,
  ) async* {
    // TODO: Add Logic
    if (event is GetQrcode) {
      yield LoadingQrcodeState();
      final response = await http.get('http://119.246.37.218:3000/qrcode/generate/${event.userId}');
      yield LoadedQrcodeState(json.decode(response.body)['token']);
    }
  }
}
