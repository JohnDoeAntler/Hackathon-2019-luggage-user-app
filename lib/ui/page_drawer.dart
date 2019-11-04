import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luggage_app_final/bloc/bloc.dart';

class PageDrawer extends StatelessWidget {
@override
  Widget build(BuildContext context) {
    final UserBloc userBloc = BlocProvider.of<UserBloc>(context);

    return Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Luggage Management System"),
              accountEmail: Text("Hackathon 2019"),
              decoration: BoxDecoration(
                color: Color.fromRGBO(0x00, 0x64, 0x5A, 1)
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 30.0,
                  backgroundColor: Colors.transparent,
                  child: ClipOval(
                    child: Image.network(
                      "https://pbs.twimg.com/profile_images/526631556341719040/PGyxRgFH_400x400.jpeg",
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text('Home'),
              leading: Icon(Icons.home),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Container(
              height: 1.0,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 1.0, color: Colors.black12)
                )
              ),
            ),
            ListTile(
              title: Text('Notification'),
              leading: Icon(Icons.notifications),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Container(
              height: 1.0,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 1.0, color: Colors.black12)
                )
              ),
            ),
            ListTile(
              title: Text('Setting'),
              leading: Icon(Icons.settings),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Container(
              height: 1.0,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 1.0, color: Colors.black12)
                )
              ),
            ),
            ListTile(
              title: Text('Sign Out'),
              leading: Icon(Icons.exit_to_app),
              onTap: () {
                userBloc.dispatch(ResetUser());

                Navigator.of(context).pushReplacementNamed('/login');
              },
            ),
          ],
        ),
      );
  }
}