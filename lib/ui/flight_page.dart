import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:luggage_app_final/bloc/bloc.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:tuple/tuple.dart';

class FlightPage extends StatefulWidget {
  @override
  _FlightPageState createState() => _FlightPageState();
}

class _FlightPageState extends State<FlightPage> {
  final flightBloc = FlightBloc();

  @override
  Widget build(BuildContext context) {

    final userBloc = BlocProvider.of<UserBloc>(context);

    flightBloc.dispatch(
      GetFlight(
        flightId: userBloc.currentState.props[0].flightId,
        airplaneClassId: userBloc.currentState.props[0].airplaneClassId,  
      )
    );

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
                    image: 'https://images.pexels.com/photos/1387551/pexels-photo-1387551.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
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
            child: Container(
              child: Opacity(
                opacity: 0.8,
                child: Container(
                  height: 205,
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
                        bloc: flightBloc,
                        builder: (context, state) {
                          if (state is LoadedFlightState) {
                            List<Tuple3<Icon, String, String>> arr =
                                <Tuple3<Icon, String, String>>[
                              Tuple3(
                                  Icon(Icons.attach_money),
                                  'Class of travel',
                                  "${state.classOfTravel}"),
                              Tuple3(
                                  Icon(Icons.assignment_returned),
                                  'Flight\'s total assigned space',
                                  "${state.totalAssigned.round()} cm^3"),
                              Tuple3(
                                  Icon(Icons.shopping_cart),
                                  'Remaining space',
                                  "${state.remainingSpace.round()} cm^3"),
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
                          } else if (state is LoadingFlightState) {
                            return Center(
                              child: Container(),
                            );
                          } else if (state is InitialFlightState) {
                            return Container();
                        }
                      },
                    )
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose(){
    super.dispose();
    flightBloc.dispose();
  }
}