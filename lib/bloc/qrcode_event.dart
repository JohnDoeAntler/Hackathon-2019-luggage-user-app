import 'package:equatable/equatable.dart';

abstract class QrcodeEvent extends Equatable {
  QrcodeEvent([List props = const []]) : super(props);
}

class GetQrcode extends QrcodeEvent {
  final userId;

  GetQrcode(this.userId) : super([userId]);
}
