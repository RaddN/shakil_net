import 'dart:convert';

import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:http/http.dart' as http;
class PlayListVideoPlay extends StatefulWidget {
  final Banner_DocumentId;
  final VideoDetails;
  final YtbVideoId;
  final NextPageTokenid;
  const PlayListVideoPlay({Key? key, this.Banner_DocumentId,this.VideoDetails,this.YtbVideoId,this.NextPageTokenid}) : super(key: key);

  @override
  _PlayListVideoPlayState createState() => _PlayListVideoPlayState();
}

class _PlayListVideoPlayState extends State<PlayListVideoPlay> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;
  var videoplayer=false;
  var NextPageTokenid;
  @override
  void initState() {
    super.initState();
    setState(() {
      NextPageTokenid =widget.NextPageTokenid;
    });
    _controller = widget.VideoDetails==null? VideoPlayerController.network("${widget.Banner_DocumentId['videoSrc']}"):VideoPlayerController.network("${widget.VideoDetails['videoSrc']}");
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      autoPlay: false,
      looping: true,
      allowFullScreen: true,
      allowMuting: true,
      allowedScreenSleep: true,
      allowPlaybackSpeedChanging: true,
      autoInitialize: true,
      showControls: true,
      deviceOrientationsAfterFullScreen: DeviceOrientation.values,
    );
  }

  @override
  Widget build(BuildContext context) {
    String videoId;
    widget.YtbVideoId== null?
    videoId =widget.VideoDetails==null?YoutubePlayer.convertUrlToId("${widget.Banner_DocumentId['videoSrc']}").toString():YoutubePlayer.convertUrlToId("${widget.VideoDetails['videoSrc']}").toString():
    videoId =widget.YtbVideoId;
    YoutubePlayerController _YoubeVideocontroller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        // isLive: true,
          autoPlay: false,
          loop: true,
          controlsVisibleAtStart: true,
          hideThumbnail: true,
          enableCaption: true,
          useHybridComposition: true
      ),

    );
    var CollectionId = widget.Banner_DocumentId['MovieName'];
    var MoreVideo = NextPageTokenid==null?MoreVideoList(VideoDetails: widget.VideoDetails,Banner_DocumentId: widget.Banner_DocumentId,YtbVideoId: widget.YtbVideoId)
        :
    MoreVideoList(VideoDetails: widget.VideoDetails,Banner_DocumentId: widget.Banner_DocumentId,YtbVideoId: widget.YtbVideoId,Tokenid: NextPageTokenid,);
    Stream<QuerySnapshot> VideoData = FirebaseFirestore.instance.collectionGroup(CollectionId).snapshots();
    return Scaffold(
      body: Column(
        children: [
          widget.Banner_DocumentId['websiteUrl']=='https://www.youtube.com'?
          Container(
            height: 280,
            child: YoutubePlayerBuilder(
              player: YoutubePlayer(
                controller: _YoubeVideocontroller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.blue,
                topActions: [
                  IconButton(onPressed: () {
                    Navigator.pop(context);
                  }, icon: Icon(FontAwesomeIcons.arrowLeft,color: Colors.white,))
                ],
                // liveUIColor: Colors.blue,
                bottomActions: [
                  CurrentPosition(),
                  ProgressBar(isExpanded: true),
                  CurrentPosition(),
                  FullScreenButton(),
                ],
              ),
              builder: (context, player) {
                return player;
              },
            ),
          ):
          Container(
            height: 280,
            color: Colors.black,
            child: Chewie(controller: _chewieController),
          ),
          widget.Banner_DocumentId['Category'].toString().contains('Auto')?
          Expanded(child: MoreVideo):
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: VideoData,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                return GridView(gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                  childAspectRatio: 100/25

                ),
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                    return InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PlayListVideoPlay(Banner_DocumentId: widget.Banner_DocumentId,VideoDetails: data,),));
                      },
                      child: Card(
                        color: Colors.grey,
                        child: Row(
                          children: [
                            SizedBox(width:150, child: Image.network(widget.Banner_DocumentId['BannerSrc'])),
                            SizedBox(width: 20,),
                            Expanded(
                              child: Text(data['Name'],style: TextStyle(

                                    color: Colors.white,
                                    fontSize: 12
                                ),),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            )
          ),
        ],
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _controller.pause();
  }
}

class MoreVideoList extends StatefulWidget {
  final Banner_DocumentId;
  final VideoDetails;
  final YtbVideoId;
  final Tokenid;
  const MoreVideoList({Key? key, this.Banner_DocumentId,this.VideoDetails,this.YtbVideoId,this.Tokenid}) : super(key: key);

  @override
  _MoreVideoListState createState() => _MoreVideoListState();
}

class _MoreVideoListState extends State<MoreVideoList> {
  var PlayListdata;
  var ytbVideoCount;
  var NextPageTokenid;
  Future<void> addPlaylist() async{
    var base_url = "https://www.googleapis.com/youtube/v3/";
    // https://www.googleapis.com/youtube/v3/playlistItems?order=date&part=snippet&channelId=UCpEhnqL0y41EpW2TvWAHD7Q&playlistId=PLzufeTFnhupwdq1nYAZDkYn-ao0ZqOuAr&maxResults=50&key=AIzaSyAAg_iZjvvZ2NfPmVnlsApeTXLr5nw-GwA
    var key = "AIzaSyAAg_iZjvvZ2NfPmVnlsApeTXLr5nw-GwA";
    var  channelid=widget.Banner_DocumentId['ChannelId']
    ,playlistid=widget.Banner_DocumentId['PlayListID'],
        maxresult = widget.Banner_DocumentId['TotalVideos'];

    var API_URL =widget.Tokenid==null? "${base_url}playlistItems?order=date&part=snippet&channelId=${channelid}&playlistId=${playlistid}&maxResults=${maxresult}&key=${key}":"${base_url}playlistItems?order=date&part=snippet&channelId=${channelid}&playlistId=${playlistid}&maxResults=${maxresult}&pageToken=${widget.Tokenid}&key=${key}";

    // CollectionReference Playlist = FirebaseFirestore.instance.collection('Learning_playlist').doc(SubCollectionName).collection(SubCollectionName);
    var response =await http.get(Uri.parse(API_URL));
    setState(() {
      var decode = json.decode(response.body);
      PlayListdata = decode;
      ytbVideoCount =decode['items'];
      NextPageTokenid =PlayListdata['nextPageToken'];
      print(PlayListdata);
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addPlaylist();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(itemCount: ytbVideoCount==null?0:ytbVideoCount.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PlayListVideoPlay(Banner_DocumentId: widget.Banner_DocumentId,YtbVideoId: PlayListdata['items'][index]["snippet"]['resourceId']['videoId'],NextPageTokenid: NextPageTokenid,),));
                },
                child: Card(
                  color: Colors.grey,
                  child: Row(
                    children: [
                      SizedBox(width:150, child: Image.network(PlayListdata['items'][index]['snippet']['thumbnails']['default']['url'])),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Text(PlayListdata['items'][index]["snippet"]['title'],style: TextStyle(

                            color: Colors.white,
                            fontSize: 12
                        ),),
                      ),
                    ],
                  ),
                ),
              );
            },),
        ),
        NextPageTokenid==null?ElevatedButton(onPressed: () {
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context) => PlayListVideoPlay(Banner_DocumentId: widget.Banner_DocumentId),));
        }, child: Text('Back')):
            ElevatedButton(onPressed: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => PlayListVideoPlay(Banner_DocumentId: widget.Banner_DocumentId,NextPageTokenid: NextPageTokenid,),));
            }, child: Text('Load More'))
      ],
    );
  }
}

