import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finaltestfirebase/main.dart';
import 'package:finaltestfirebase/playlistVideoplay.dart';
import 'package:finaltestfirebase/sncvideoplayer.dart';
import 'package:finaltestfirebase/video_play_details/live_tv_play.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  final Userinfo;
  SearchPage({Key? key,required this.Userinfo}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final Stream<QuerySnapshot> MoviesData =
      FirebaseFirestore.instance.collection('All_Movies').snapshots();
  final Stream<QuerySnapshot> TvChanelData =
      FirebaseFirestore.instance.collection('tv_channel').snapshots();
  final Stream<QuerySnapshot> Playlist =
      FirebaseFirestore.instance.collection('Learning_playlist').snapshots();
  var MyQueryData;
  var showMovie=false;
  var showTv =false;
  var showPlaylist =false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            height: 40,
            child: TextFormField(
              onChanged: (value) {
                setState(() {
                  MyQueryData = value;
                });
                FirebaseFirestore.instance
                    .collection('All_Movies')
                    .get()
                    .then((QuerySnapshot querySnapshot) {
                  querySnapshot.docs.forEach((doc) {
                    doc['MovieName'].toString().contains(RegExp(r'[A-Z]'))?
                    setState(() {
                      showMovie = true;
                    }):setState(() {
                      showMovie = false;
                    });
                  });
                });
                FirebaseFirestore.instance
                    .collection('Learning_playlist')
                    .get()
                    .then((QuerySnapshot querySnapshot) {
                  querySnapshot.docs.forEach((doc) {
                    setState(() {
                      showPlaylist = doc['MovieName'].toString().contains(RegExp(r'[A-Z]'))?true:false;
                    });
                  });
                });
                FirebaseFirestore.instance
                    .collection('tv_channel')
                    .get()
                    .then((QuerySnapshot querySnapshot) {
                  querySnapshot.docs.forEach((doc) {
                    doc['name'].toString().contains(RegExp(r'[A-Z]'))?
                    setState(() {
                      showTv = true;
                    }):setState(() {
                      showTv = false;
                    });
                  });
                });
              },
            )),
      ),
      body: ListView(
        children: [
          showMovie ==true?Container():
          ShowData(StreamData: MoviesData,title: 'Movies'),
          showTv==false?Container():
          ShowData(StreamData: TvChanelData,title: 'TV Channel'),
          showPlaylist==false?Container():
          ShowData(StreamData: Playlist,title: 'Learning,Cartoon and Playlist'),
        ],
      ),
    );
  }

  Column ShowData({required StreamData,required title}) {
    return Column(
      children: [
        Titlebar(
          TitleText: title,
          Userinfo: widget.Userinfo,
        ),
        SizedBox(
          height: 300,
          child: StreamBuilder<QuerySnapshot>(
            stream: StreamData,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }

              return GridView(
                  scrollDirection: Axis.horizontal,
                  gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  children: [
                    ...snapshot.data!.docs
                        .where((QueryDocumentSnapshot<Object?> element) => element[
                                StreamData == MoviesData || StreamData == Playlist
                                    ? 'MovieName'
                                    : 'name']
                            .toString()
                            .toLowerCase()
                            .contains(MyQueryData.toString().toLowerCase()))
                        .map((QueryDocumentSnapshot<Object?> data) {
                      return StreamData == MoviesData || StreamData == Playlist
                          ? InkWell(
                              onTap: () {
                                if (StreamData == MoviesData)
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SncVideoPlay(
                                          MovieData: data,
                                          Userinfo: widget.Userinfo,
                                        ),
                                      ));
                                if (StreamData == Playlist)
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => PlayListVideoPlay(Banner_DocumentId: data,),));
                              },
                              child: Card(
                                color: Colors.grey,
                                child: Container(
                                  alignment: Alignment.bottomCenter,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        data['MovieName'],
                                        style: TextStyle(
                                            backgroundColor: Colors.black,
                                            color: Colors.white),
                                      ),
                                      Text(
                                          StreamData == Playlist
                                              ? ''
                                              : data['Published'],
                                          style: TextStyle(
                                              backgroundColor: Colors.black,
                                              color: Colors.white))
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(data['BannerSrc']))),
                                ),
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          SncLiveTvPlay(MovieData: data,
                                            Userinfo: widget.Userinfo,),
                                    ));
                              },
                              child: Card(
                                  color: Colors.white,
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(data['name']),
                                        data['WebsiteUrl'] == 'http://tv.fanush.net'
                                            ? Text(
                                                'Fast',
                                                style: TextStyle(
                                                    backgroundColor: Colors.green,
                                                    color: Colors.white),
                                              )
                                            : Text('Slow',
                                                style: TextStyle(
                                                    backgroundColor: Colors.red,
                                                    color: Colors.white)),
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(data['ImgSrc']))),
                                  )));
                    })
                  ]);
            },
          ),
        ),
      ],
    );
  }
}
