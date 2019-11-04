import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luggage_app_final/bloc/bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String ticketId;

  @override
  Widget build(BuildContext context) {

    final UserBloc userBloc = BlocProvider.of<UserBloc>(context);

    return Scaffold(
      backgroundColor: Color.fromRGBO(0x00, 0x64, 0x5A, 1),
      body: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: Opacity(
              opacity: 0.25,
              child: Image.network(
                'https://images.pexels.com/photos/2033343/pexels-photo-2033343.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox.expand(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 80,
                  ),
                  CircleAvatar(
                    radius: 80,
                    child: FlutterLogo(
                      size: 160,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Welcome back, User',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 32,
                      fontWeight: FontWeight.w300
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.confirmation_number),
                            labelText: 'Ticket Number',
                            hintText: 'Please enter the ticket number here.',
                            labelStyle: TextStyle(
                              color: Colors.white70,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.white54
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.white70
                          ),
                          autofocus: true,
                          onChanged: (str) {
                            setState(() {
                              ticketId = str;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Enim aute consectetur cupidatat sunt quis ut anim ea irure deserunt ullamco adipisicing eiusmod irure. Qui eiusmod ipsum non aliquip dolor do irure irure. Enim nisi ex mollit excepteur et aliqua id irure.',
                          style: TextStyle(
                            color: Colors.white54
                          ),
                        ),
                        SizedBox(
                          height: 120,
                        ),
                        BlocListener(
                          bloc: userBloc,
                          listener: (context, state) {
                            if (state is ErrorUserState) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Error'),
                                    content: Text(state.errorType == "RangeError" ? "Ticket number is invalid." : "Server is maintaining, please try again later."),
                                    actions: <Widget>[
                                      FlatButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('Close')
                                      ),
                                    ],
                                  );
                                }
                              );
                            } else if (state is LoadedUserState) {
                              if (state.user.id != null) {
                                Navigator.pushReplacementNamed(context, '/home');
                              }
                            }
                          },
                          child: BlocBuilder(
                            bloc: userBloc,
                            builder: (context, state) {
                              if (state is InitialUserState) {
                                return LoginButton(ticketId);
                              } else if(state is LoadingUserState) {
                                return CircularProgressIndicator();
                              } else if (state is ErrorUserState) {
                                return LoginButton(ticketId);
                              } else return Container();
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}

class LoginButton extends StatelessWidget {
  
  final String ticketId;

  const LoginButton(this.ticketId);

  @override
  Widget build(BuildContext context) {

    final UserBloc userBloc = BlocProvider.of<UserBloc>(context);

    return ButtonTheme(
      minWidth: 400,
      height: 50,
      child: FlatButton(
        color: Colors.transparent,
        onPressed: () {
          userBloc.dispatch(GetUser(ticketId));
        },
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(25.0),
          side: BorderSide(color: Colors.blueAccent)
        ),
        splashColor: Colors.blueAccent,
        child: Text(
          'Login'.toUpperCase(),
          style: TextStyle(
            color: Colors.blueAccent,
            fontSize: 24,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}