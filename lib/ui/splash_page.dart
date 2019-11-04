import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(seconds: 1), () => {
      Navigator.of(context).pushReplacementNamed('/login')
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0x00, 0x64, 0x5A, 1),
      body: Center(
        child: CircleAvatar(
          radius: 80,
          child: FlutterLogo(
            size: 80,
          ),
        ),
      ),
    );
  }
}