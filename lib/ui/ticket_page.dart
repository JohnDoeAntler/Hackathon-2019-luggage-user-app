import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lottie/flutter_lottie.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:luggage_app_final/bloc/bloc.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:tuple/tuple.dart';

class TicketPage extends StatefulWidget {
  @override
  _TicketPageState createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  final TicketBloc ticketBloc = TicketBloc();

  @override
  Widget build(BuildContext context) {

    final UserBloc userBloc = BlocProvider.of(context);

    UserState userState = userBloc.currentState;

    ticketBloc.dispatch(GetTicket(
        userId: userState.props[0].id,
        airplaneClassId: userState.props[0].airplaneClassId));

    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Container(
              width: 385,
              height: 605,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0)
                )
              ),
              child: new ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(80.0),
                  topRight: Radius.circular(80.0),
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                ),
                child: Opacity(
                  opacity: 0.8,
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: 'https://images.pexels.com/photos/1007793/pexels-photo-1007793.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Opacity(
              opacity: 0.8,
              child: Container(
                height: 270,
                width: MediaQuery.of(context).size.width - 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(80.0),
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                  ),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BlocBuilder(
                      bloc: ticketBloc,
                      builder: (context, state) {
                        if (state is LoadedTicketState) {

                          List<Tuple3<Icon, String, String>> arr =
                              <Tuple3<Icon, String, String>>[
                            Tuple3(
                                Icon(Icons.confirmation_number),
                                'Ticket number',
                                "${userState.props[0].ticketId}"),
                            Tuple3(
                                Icon(Icons.airline_seat_recline_normal),
                                'Seat number',
                                "${userState.props[0].seatIndex}"),
                            Tuple3(
                                Icon(Icons.assignment_returned),
                                'Assigned space',
                                "${state.assignedSpace.round()} cm^3 of ${state.assignableSpace.round()} cm^3"),
                            Tuple3(
                                Icon(Icons.shopping_cart),
                                'Purchased space',
                                "${state.purchasedSpace.round()} cm^3 of ${state.purchasableSpace.round()} cm^3"),
                          ];

                          return AnimationLimiter(
                            child: ListView.builder(
                              itemCount: arr.length,
                              itemBuilder: (BuildContext context, int index) {
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 1000),
                                  child: SlideAnimation(
                                    verticalOffset: 20.0,
                                    child: FadeInAnimation(
                                      child: Container(
                                        height: 60,
                                        child: ListTile(
                                          leading: arr[index].item1,
                                          title: Text(arr[index].item2),
                                          subtitle: Text(arr[index].item3),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else if (state is LoadingTicketState) {
                          return Center(
                            child: Container(),
                          );
                        } else if (state is InitialTicketState) {
                          return Center(
                            child: RaisedButton(
                              onPressed: () => {
                                ticketBloc.dispatch(GetTicket(
                                    userId: userState.props[0].id,
                                    airplaneClassId: userState.props[0].airplaneClassId
                                )
                              )
                            },
                          ),
                        );
                      }
                    },
                  )
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    ticketBloc.dispose();
  }
}
