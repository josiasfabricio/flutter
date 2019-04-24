import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favtube/blocs/videos_bloc.dart';
import 'package:favtube/delegates/data_search.dart';
import 'package:favtube/widgets/video_tile.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            child: Text("0",
                style: TextStyle(
                  color: Colors.yellow,
                )),
          ),
          IconButton(
            icon: Icon(Icons.star),
            color: Colors.yellow,
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String result =
                  await showSearch(context: context, delegate: DataSearch());
              if (result != null)
                BlocProvider.of<VideosBloc>(context).inSearch.add(result);
            },
          )
        ],
      ),
      body: StreamBuilder(
          stream: BlocProvider.of<VideosBloc>(context).outVideos,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return VideoTile(snapshot.data[index]);
                },
                itemCount: snapshot.data.length,
              );
            } else {
              return Container();
            }
          }),
    );
  }
}
