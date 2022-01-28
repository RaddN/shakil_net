import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class InputData extends StatefulWidget {
  const InputData({Key? key}) : super(key: key);

  @override
  _InputDataState createState() => _InputDataState();
}

class _InputDataState extends State<InputData> {
  CollectionReference users = FirebaseFirestore.instance.collection('tv_channel');
  CollectionReference movies = FirebaseFirestore.instance.collection('All_Movies');
  CollectionReference audios = FirebaseFirestore.instance.collection('audio_list');
  final Name = TextEditingController();
  final websiteUrl = TextEditingController();
  final imgSrc = TextEditingController();
  final videoSrc = TextEditingController();
  final MovieDescription = TextEditingController();
final Published = TextEditingController();
final Category_Name = TextEditingController();
  var ShowAlert=false,PlayListdata;
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    Name.dispose();
    websiteUrl.dispose();
    imgSrc.dispose();
    videoSrc.dispose();
    super.dispose();
  }
  Future<void> adddata(String ChannelName,String ChannelWeb,String ChannelImg,String ChannelVideo, String category) {
    return users
    // existing document in 'users' collection: "ABC123"
        .doc(ChannelName)
        .set({
      'name': ChannelName,
      'WebsiteUrl': ChannelWeb,
      'ImgSrc':ChannelImg,
      'VideoSrc':ChannelVideo,
      'Category' : category.split(',').map((String text) => text).toList()
    },
      SetOptions(merge: true),
    )
        .then(
            (value) => Container(color: Colors.greenAccent, child: Text('data uploaded'),)
    )
        .catchError((error) => print("Failed to merge data: $error"));

  }
  Future<void> addmovie(String ChannelName,ChannelWeb,ChannelImg,ChannelVideo, published, MovieDes,category) {
    return movies
    // existing document in 'users' collection: "ABC123"
        .doc(ChannelName)
        .set({
      'MovieName': ChannelName,
      'DownloadUrl': ChannelWeb,
      'BannerSrc':ChannelImg,
      'VideoSrc':ChannelVideo,
      'Published':published,
      'MovieDescription':MovieDes,
      'Category_Name':category.split(',').map((String text) => text).toList()
    },
      SetOptions(merge: true),
    )
        .then(
            (value) => Container(color: Colors.greenAccent, child: Text('data uploaded'),)
    )
        .catchError((error) => print("Failed to merge data: $error"));

  }
  Future<void> addaudio(String AudioName,audiosrc,AudioArtist,audioBanner) {
    return audios
    // existing document in 'users' collection: "ABC123"
        .doc(AudioName)
        .set({
      'Name': AudioName,
      'AudioSrc': audiosrc,
      'Artist ': AudioArtist,
      'AudioBannerSrc':audioBanner

    },
      SetOptions(merge: true),
    )
        .then(
            (value) => Container(color: Colors.greenAccent, child: Text('data uploaded'),)
    )
        .catchError((error) => print("Failed to merge data: $error"));

  }
  Future<void> addPlaylist(String ChannelId,PlaylistId,MaxResult,SubCollectionName) async{
    // CollectionReference Playlist = FirebaseFirestore.instance.collection('Learning_playlist').doc(SubCollectionName).collection(SubCollectionName);
   var base_url = "https://www.googleapis.com/youtube/v3/";
    // https://www.googleapis.com/youtube/v3/playlistItems?order=date&part=snippet&channelId=UCpEhnqL0y41EpW2TvWAHD7Q&playlistId=PLzufeTFnhupwdq1nYAZDkYn-ao0ZqOuAr&maxResults=50&key=AIzaSyAAg_iZjvvZ2NfPmVnlsApeTXLr5nw-GwA
   var key = "AIzaSyAAg_iZjvvZ2NfPmVnlsApeTXLr5nw-GwA";
   var  channelid=ChannelId
   ,playlistid=PlaylistId,
    maxresult = MaxResult;
   var API_URL = "${base_url}playlistItems?order=date&part=snippet&channelId=${channelid}&playlistId=${playlistid}&maxResults=${maxresult}&key=${key}";
    var response =await http.get(Uri.parse(API_URL));
    setState(() {
      var decode = json.decode(response.body);
      PlayListdata = decode['items'];
      print(PlayListdata);
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body:
          ListView(
            children: [
              Text('ChannelName/MovieName/AudioName/ChannelId'),
              Container(
                height: 40,
                padding: EdgeInsets.only(right: 15,left: 15),
                child: TextFormField(
                  controller: Name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white,width: 0),borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    suffixIcon: Icon(Icons.search,color: Colors.white,),
                  ),
                ),
              ),
              Text('VideoSrc/audiosrc/PlaylistId'),
              Container(
                height: 40,
                padding: EdgeInsets.only(right: 15,left: 15),
                child: TextFormField(
                  controller: videoSrc,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white,width: 0),borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    suffixIcon: Icon(Icons.search,color: Colors.white,),
                  ),
                ),
              ),
              Text('Website Url/DownloadUrl/AudioArtist/MaxResult'),
              Container(
                height: 40,
                padding: EdgeInsets.only(right: 15,left: 15),
                child: TextFormField(
                  controller: websiteUrl,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white,width: 0),borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    suffixIcon: Icon(Icons.search,color: Colors.white,),
                  ),
                ),
              ),
               Text('Img Src/BannerSrc/audioBanner/SubCollectionName'),
              Container(
                height: 40,
                padding: EdgeInsets.only(right: 15,left: 15),
                child: TextFormField(
                  controller: imgSrc,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white,width: 0),borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    suffixIcon: Icon(Icons.search,color: Colors.white,),
                  ),
                ),
              ), Text('MovieDescription'),
              Container(
                height: 40,
                padding: EdgeInsets.only(right: 15,left: 15),
                child: TextFormField(
                  controller: MovieDescription,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white,width: 0),borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    suffixIcon: Icon(Icons.search,color: Colors.white,),
                  ),
                ),
              ),
        Text('Category_Name'),
              Container(
                height: 40,
                padding: EdgeInsets.only(right: 15,left: 15),
                child: TextFormField(
                  controller: Category_Name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white,width: 0),borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    suffixIcon: Icon(Icons.search,color: Colors.white,),
                  ),
                ),
              ),
          Text('Published'),
              Container(
                height: 40,
                padding: EdgeInsets.only(right: 15,left: 15),
                child: TextFormField(
                  controller: Published,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white,width: 0),borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    suffixIcon: Icon(Icons.search,color: Colors.white,),
                  ),
                ),
              ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(onPressed: () => adddata(Name.text, websiteUrl.text, imgSrc.text, videoSrc.text,Category_Name.text), child: Text('Add TV')),
            ElevatedButton(onPressed: () => addaudio(Name.text, videoSrc.text ,websiteUrl.text ,imgSrc.text), child: Text('Add Music')),
            ElevatedButton(onPressed: () => addPlaylist(Name.text, videoSrc.text, websiteUrl.text, imgSrc.text), child: Text('Add Playlist')),
            ElevatedButton(onPressed: () => addmovie(Name.text, websiteUrl.text, imgSrc.text, videoSrc.text,Published.text,MovieDescription.text,Category_Name.text), child: Text('Add Movie'))
          ],
        ),
              PlayListdata==null?Container():
                  SizedBox(
                    height: 500,
                    child: ListView.builder(itemCount: PlayListdata==null?0:PlayListdata.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                          },
                          title: Text(PlayListdata[index]["snippet"]['title']),
                          subtitle: Text(PlayListdata[index]["snippet"]['resourceId']['videoId']),
                          leading: CircleAvatar(child: Image.network(PlayListdata[index]['snippet']['thumbnails']['default']['url'],fit: BoxFit.fitHeight,),),
                        );
                      },),
                  )

            ],
          ),
    );
  }
}
