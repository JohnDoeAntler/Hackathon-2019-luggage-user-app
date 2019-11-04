import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:luggage_app_final/bloc/bloc.dart';
import 'package:luggage_app_final/ui/luggage_page.dart';
import 'package:transparent_image/transparent_image.dart';

class LuggagesPage extends StatefulWidget {
  @override
  _LuggagesPageState createState() => _LuggagesPageState();
}

class _LuggagesPageState extends State<LuggagesPage> {
  final LuggagesBloc luggagesBloc = LuggagesBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
        bloc: BlocProvider.of<UserBloc>(context),
        listener: (context, userState) {
          if (userState is LoadedUserState) {
            luggagesBloc.dispatch(GetLuggages(userState.user.id));
          }
        },
        child: BlocBuilder(
          bloc: luggagesBloc,
          builder: (context, luggagesState) {
            if (luggagesState is LoadedLuggagesState) {
              if (luggagesState.luggages.length > 0) {
                return Container(
                  child: AnimationLimiter(
                    child: ListView.builder(
                      itemCount: luggagesState.luggages.length,
                      itemBuilder: (BuildContext context, int index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 1000),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: CustomListItemTwo(
                                thumbnail: luggagesState.luggages[index].imageUrl,
                                id: luggagesState.luggages[index].id,
                                length: luggagesState.luggages[index].length,
                                width: luggagesState.luggages[index].width,
                                height: luggagesState.luggages[index].height,
                                scannedTime: luggagesState.luggages[index].createdAt.toString(),
                                index: luggagesState.luggages[index].spaceIndex
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                );
              } else {
                return Container(
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.warning, size: 30, color: Colors.white70),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        'You have no any scanned luggages.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  )
                ),
              );
            }
          } else {
            return Container(
              child: Center(
                child: Container(),
              ),
            );
          }
        },
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
    luggagesBloc.dispose();
  }
}

class _ArticleDescription extends StatelessWidget {
  _ArticleDescription({
    Key key,
    this.id,
    this.length,
    this.width,
    this.height,
    this.scannedTime,
    this.index,
  }) : super(key: key);

  final int id;
  final double length;
  final double width;
  final double height;
  final String scannedTime;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Luggage - $id',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Text(
                'Length: $length, Width: $width, Height: $height',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.white70,
                ),
              ),
              Text(
                'Assigned space index: $index',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                'Scanned at: $scannedTime',
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomListItemTwo extends StatelessWidget {
  CustomListItemTwo({
    Key key,
    this.thumbnail,
    this.id,
    this.length,
    this.width,
    this.height,
    this.scannedTime,
    this.index,
  }) : super(key: key);

  final String thumbnail;
  final int id;
  final double length;
  final double width;
  final double height;
  final String scannedTime;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LuggagePage(
              thumbnail: thumbnail,
              id: id,
              length: length,
              width: width,
              height: height,
              scannedTime: scannedTime,
              index: index,
            )
          ),
        )
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: SizedBox(
          height: 100,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 1.0,
                  child: CircleAvatar(
                    backgroundColor: Colors.black12,
                    child: ClipOval(
                      child: Hero(
                        tag: 'luggage-$id',
                        child: FadeInImage.memoryNetwork(
                          image: thumbnail,
                          placeholder: kTransparentImage,
                          fit: BoxFit.cover,
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                    child: _ArticleDescription(
                        id: id,
                        length: length,
                        width: width,
                        height: height,
                        scannedTime: scannedTime,
                        index: index),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
