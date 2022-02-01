import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../main.dart';


class SncLiveTvPlay extends StatefulWidget {
  final MovieData;
  final VideoUrl;
  final Userinfo;
  const SncLiveTvPlay({Key? key, this.MovieData,this.VideoUrl,required this.Userinfo}) : super(key: key);
  @override
  _SncLiveTvPlayState createState() => _SncLiveTvPlayState();
}


class _SncLiveTvPlayState extends State<SncLiveTvPlay> {
  var dropdowntext=4;
  late VideoPlayerController _controller;
  late ChewieController _chewieController;
  var videoplayer=false;
  var InitialPage =0;
  InAppWebViewController? _webViewController;
  @override
  void initState() {
    super.initState();
    _controller = widget.VideoUrl==null? VideoPlayerController.network("${widget.MovieData['VideoSrc']}"):VideoPlayerController.network(widget.VideoUrl);
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
    videoId =widget.VideoUrl==null? YoutubePlayer.convertUrlToId("${widget.MovieData['VideoSrc']}").toString():YoutubePlayer.convertUrlToId("${widget.VideoUrl}").toString();
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
    var ScreenHeight = MediaQuery.of(context).size.height;
    if (kIsWeb) {
      return DefaultTabController(
        initialIndex: 0,
        length: 7,
        child: Scaffold(
          body: Column(
            children: [
              ElevatedButton(
              onPressed: _launchURL,
              child: Text('Watch TV'),
            ),
              buildTabBar(),
              Expanded(
                child: buildTabBarView(ScreenHeight),
              ),
            ]
          ),
        ),
      );
      // running on the web!
    } else {
      return  DefaultTabController(
        initialIndex: 0,
        length: 7,
        child: Scaffold(
          body: Column(
            children: [
              widget.VideoUrl==null?
              widget.MovieData['WebsiteUrl']=="https://www.youtube.com" || widget.MovieData['WebsiteUrl']=="https://bongobd.com" || widget.MovieData['WebsiteUrl']=="https://www.bioscopelive.com"?Container():
          Container(
              height: 280,
              color: Colors.black,
              child: Chewie(controller: _chewieController),
            ):Container(
                height: 280,
                color: Colors.black,
                child: Chewie(controller: _chewieController),
              ),
              widget.VideoUrl==null?
              widget.MovieData['WebsiteUrl']=="https://www.youtube.com"?
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
                      RemainingDuration(),
                      PlaybackSpeedButton(),
                      FullScreenButton(),
                    ],
                  ),
                  builder: (context, player) {
                    return player;
                  },
                ),
              ):Container():Container(),
              widget.VideoUrl==null?
              widget.MovieData['WebsiteUrl']=="https://bongobd.com" || widget.MovieData['WebsiteUrl']=="https://www.bioscopelive.com"?
              Stack(
                children: [
                  SizedBox(
                  height: 340,
                  child: GestureDetector(
                    onHorizontalDragUpdate: (updateDetails) {},
                    onVerticalDragUpdate: (updateDetails) {

                    },
                    child: InAppWebView(
                      initialUrlRequest: URLRequest(url: Uri.parse("${widget.MovieData['VideoSrc']}")),
                      onEnterFullscreen: (controller) =>  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight,DeviceOrientation.landscapeLeft]),
                      onExitFullscreen: (controller) => SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]),
                    ),
                  ),
                ),
                  Container(
                    color: Colors.black,
                    height: 60,
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    height: 335,
                    child: Container(
                      height: 70,
                      color: Colors.black,
                    ),
                  ),
                ]
              ):Container():Container(),
              SizedBox(height: 10,),
              buildTabBar(),
              Expanded(
                child: buildTabBarView(ScreenHeight),
              ),
            ],
          ),
        ),
      );
      // NOT running on the web! You can check for additional platforms here.
    }
  }

  TabBarView buildTabBarView(double ScreenHeight) {
    return TabBarView(
                  children: [
                    GridviewMovieTv(Heightsnc:ScreenHeight-270,ScroolDirection:'vertical',type:"tv",
                      Userinfo: widget.Userinfo,),
                    GridviewMovieTv(Heightsnc:ScreenHeight-270,ScroolDirection:'vertical',type:"tv",QueryData:'Sports',
                      Userinfo: widget.Userinfo,),
                    GridviewMovieTv(Heightsnc:ScreenHeight-270,ScroolDirection:'vertical',type:"tv",QueryData:'Movies',
                      Userinfo: widget.Userinfo,),
                    GridviewMovieTv(Heightsnc:ScreenHeight-270,ScroolDirection:'vertical',type:"tv",QueryData:'Bangla',
                      Userinfo: widget.Userinfo,),
                    GridviewMovieTv(Heightsnc:ScreenHeight-270,ScroolDirection:'vertical',type:"tv",QueryData:'Hindi',
                      Userinfo: widget.Userinfo,),
                    GridviewMovieTv(Heightsnc:ScreenHeight-270,ScroolDirection:'vertical',type:"tv",QueryData:'English',
                      Userinfo: widget.Userinfo,),
                    GridviewMovieTv(Heightsnc:ScreenHeight-270,ScroolDirection:'vertical',type:"tv",QueryData:'Cartoon',
                      Userinfo: widget.Userinfo,),

                  ]);
  }

  TabBar buildTabBar() {
    return TabBar(
            labelColor: Colors.black,
            tabs: [
              Tab(text: 'All',icon: Container(),),
              Tab(text: 'Sports',icon: Container(),),
              Tab(text: 'Movies',icon: Container(),),
              Tab(text: 'Bangla',icon: Container(),),
              Tab(text: 'Hindi',icon: Container(),),
              Tab(text: 'English',icon: Container(),),
              Tab(text: 'Cartoon',icon: Container(),),
            ]);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _controller.pause();
  }
}
void _launchURL() async {
  String _url = 'http://tv.fanush.net/';
  if (!await launch(_url)) throw 'Could not launch $_url';
}
