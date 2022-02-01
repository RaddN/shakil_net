import 'package:chewie/chewie.dart';
import 'package:finaltestfirebase/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/cupertino.dart';
class SncVideoPlay extends StatefulWidget {
  final MovieData;
  final Userinfo;
  const SncVideoPlay({Key? key, this.MovieData,this.Userinfo,}) : super(key: key);
  @override
  _SncVideoPlayState createState() => _SncVideoPlayState();
}

class _SncVideoPlayState extends State<SncVideoPlay> {
  var dropdowntext=4;
  late VideoPlayerController _controller;
  late ChewieController _chewieController;
  var videoplayer=false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network("${widget.MovieData['VideoSrc']}");
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
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 400,
                color: Colors.grey,
              ),
              Container(height: 280,alignment: Alignment.center, child: Image.network("${widget.MovieData['BannerSrc']}",fit: BoxFit.cover,)),
              Positioned(
                  bottom: 250,
                  left: screenWidth/2.5,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        videoplayer = true;
                      });
                    },
                    child: Container(
                      height: 70,
                      width: 70,
                      child: Icon(Icons.arrow_right, color: Colors.white,size: 35,),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(163, 163, 163, 0.5098039215686274),
                          shape: BoxShape.circle
                      ),
                    ),
                  )
              ),
              Positioned(
                top: 200,
                child: Container(
                  alignment: Alignment.topCenter,
                  height: 200,
                  width: screenWidth,
                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                      Text("${widget.MovieData['MovieName']}",textAlign: TextAlign.center, style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 24
                      ),),
                      SizedBox(height: 5,),
                      Text("${widget.MovieData['Category_Name']}",style: TextStyle(
                          color: Color.fromARGB(122, 69, 8, 1),
                          fontWeight: FontWeight.w700,
                          fontSize: 16
                      ), ),
                      SizedBox(height: 15,),
                      Container(
                          width: screenWidth-100,
                          height: 80,
                          child:ListView(
                            children: [
                              Text("${widget.MovieData['MovieDescription']}",textAlign: TextAlign.center,),
                            ],
                          )
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4,
                          offset: Offset(-1, -2), // Shadow position
                        ),
                      ],
                      color: Colors.white,
                      borderRadius:BorderRadius.only(topLeft: Radius.circular(100),topRight: Radius.circular(100))
                  ),
                ),
              ),
              Visibility(
                visible: videoplayer,
                child: Container(
                  height: 280,
                  color: Colors.black,
                  child: Chewie(controller: _chewieController),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              children: [
                Titlebar(TitleText: 'You may like',

                  Userinfo: widget.Userinfo,),
                AllMovies(CrossAxisNum:2,UsingWhere:'VideoPlayPage',
                  Userinfo: widget.Userinfo,)
              ],
            ),
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
