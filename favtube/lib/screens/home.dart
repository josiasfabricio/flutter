import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favtube/blocs/favorite_bloc.dart';
import 'package:favtube/blocs/videos_bloc.dart';
import 'package:favtube/delegates/data_search.dart';
import 'package:favtube/models/video.dart';
import 'package:favtube/screens/favorites.dart';
import 'package:favtube/widgets/video_tile.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _blocVideo = BlocProvider.of<VideosBloc>(context);
    final _blocFav = BlocProvider.of<FavoriteBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 25,
          child: Image.asset("images/yt_logo.png"),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: StreamBuilder<Map<String, Video>>(
                stream: _blocFav.outFav,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text("${snapshot.data.length}");
                  } else {
                    return Container();
                  }
                }),
          ),
          IconButton(
            icon: Icon(Icons.star),
            color: Colors.yellow,
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Favorites()));
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String result =
                  await showSearch(context: context, delegate: DataSearch());
              if (result != null) _blocVideo.inSearch.add(result);
            },
          )
        ],
      ),
      body: StreamBuilder(
          stream: _blocVideo.outVideos,
          initialData: [],
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  if (index < snapshot.data.length) {
                    return VideoTile(snapshot.data[index]);
                  } else if (index > 1) {
                    _blocVideo.inSearch.add(null);
                    return Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.redAccent),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
                itemCount: snapshot.data.length + 1,
              );
            } else {
              return Container();
            }
          }),
    );
  }
}
