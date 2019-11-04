import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luggage_app_final/bloc/qrcode_bloc.dart';
import 'package:luggage_app_final/bloc/qrcode_event.dart';
import 'package:luggage_app_final/bloc/qrcode_state.dart';
import 'package:luggage_app_final/bloc/user_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodePage extends StatefulWidget {
  @override
  _QRCodePageState createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {

  final QrcodeBloc qrcodeBloc = QrcodeBloc();

  @override
  Widget build(BuildContext context) {

    final UserBloc userBloc = BlocProvider.of<UserBloc>(context);

    qrcodeBloc.dispatch(
      GetQrcode(userBloc.currentState.props[0].id)
    );

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            height: 300,
            width: 300,
            child: BlocBuilder(
              bloc: qrcodeBloc,
              builder: (context, state) {
                if (state is LoadedQrcodeState) {
                  return QrImage(
                    data: state.qrcode,
                    version: QrVersions.auto,
                    size: 300.0,
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            width: 300,
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  width: 2.0,
                  color: Colors.white70
                )
              )
            ),
            padding: EdgeInsets.only(
              left: 8.0
            ),
            child: Text(
              'Ipsum magna occaecat nostrud in ad consectetur ad sunt tempor. Nulla nulla laboris officia dolor in nisi adipisicing aliquip do ullamco officia nisi amet. Ad do aliqua aute nulla laboris cillum. Aliquip anim sunt duis velit fugiat amet Lorem cillum do aliquip aute nisi. Labore eiusmod eiusmod commodo eiusmod in id. Commodo labore irure laboris consequat.',
              style: TextStyle(
                color: Colors.white70
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          ButtonTheme(
            minWidth: 300,
            height: 60,
            child: RaisedButton(
              onPressed: () => {
                qrcodeBloc.dispatch(
                  GetQrcode(userBloc.currentState.props[0].id)
                )
              },
              color: Color.fromRGBO(0x20, 0x84, 0x7A, 1),
              child: Text(
                'Refresh'.toUpperCase(),
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 30,
                  fontWeight: FontWeight.w300
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose(){
    super.dispose();
    qrcodeBloc.dispose();
  }
}