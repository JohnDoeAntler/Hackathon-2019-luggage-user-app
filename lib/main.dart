import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luggage_app_final/bloc/bloc.dart';
import 'package:luggage_app_final/ui/home_page.dart';
import 'package:luggage_app_final/ui/login_page.dart';
import 'package:luggage_app_final/ui/splash_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final UserBloc userBloc = UserBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: userBloc,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => SplashPage(),
          '/login': (context) => LoginPage(),
          '/home': (context) => HomePage(),
        },
      ),
    );
  }

  @override
  void dispose(){
    super.dispose();
    userBloc.dispose();
  }
}
