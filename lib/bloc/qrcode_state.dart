import 'package:equatable/equatable.dart';

abstract class QrcodeState extends Equatable {
  QrcodeState([List props = const []]) : super(props);
}

class InitialQrcodeState extends QrcodeState {}

class LoadingQrcodeState extends QrcodeState {}

class LoadedQrcodeState extends QrcodeState {
  final String qrcode;

  LoadedQrcodeState(this.qrcode) : super([qrcode]);
}
