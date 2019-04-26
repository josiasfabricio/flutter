import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favtube/blocs/favorite_bloc.dart';
import 'package:favtube/models/video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:favtube/api.dart';

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FavoriteBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder<Map<String, Video>>(
          stream: bloc.outFav,
          initialData: {},
          builder: (context, snapshot) {
            return ListView(
              children: snapshot.data.values.map((video) {
                return InkWell(
                  onTap: () {
                    FlutterYoutube.playYoutubeVideoById(
                        apiKey: API_KEY, videoId: video.id);
                  },
                  onLongPress: () {
                    bloc.toggleFavorite(video);
                  },
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 50,
                        child: Image.network(video.thumb),
                      ),
                      Expanded(
                        child: Text(
                          video.title,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          }),
    );
  }
}
