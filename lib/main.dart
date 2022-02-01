import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finaltestfirebase/catamovielist.dart';
import 'package:finaltestfirebase/inputdata.dart';
import 'package:finaltestfirebase/sncvideoplayer.dart';
import 'package:finaltestfirebase/widget/mywidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'basic_home_signin_signup/signin.dart';
import 'firebase_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'playlistVideoplay.dart';
import 'splash_screen/splash_screen.dart';
import 'video_play_details/live_tv_play.dart';
import 'webViewPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:animated_radial_menu/animated_radial_menu.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SncSplashScreen(),
  ));
}

class SncMain extends StatefulWidget {
  const SncMain({Key? key}) : super(key: key);

  @override
  _SncMainState createState() => _SncMainState();
}

class _SncMainState extends State<SncMain> {
  var dropdowntext = 4;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  var Storage;
  var UID;
  var Userinfo;
  var AccountActivity;
  // CollectionReference usersStream =
  // FirebaseFirestore.instance.collection('User');
  void UserInfo(){
    FirebaseFirestore.instance
        .collection('User')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((data) {
        if(data['uid']==UID){
          setState(() {
            Userinfo = data;
            AccountActivity = data['Activity'];
          });}
      });
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SingIn(Redialmenu: Redialmenu,),));
      } else {
        setState(() {
          UID = user.uid;
        });
      }
    });
    UserInfo();
  }
  void AlertMessage(){
    if(AccountActivity!='Active'){
      showDialog(
        barrierDismissible:AccountActivity!='Inactive'?true:false,
        context: context,
        builder: (context) => SimpleDialog(
          alignment: Alignment.center,
          title: Text('ইন্টারনেট বিল সংক্রান্ত নোটিস',textAlign: TextAlign.center,style: TextStyle(
            color: Colors.red
          ),),
          children: [
            Text(AccountActivity!='Inactive'?'আপনার ইন্টারনেট বিল পরিশোধ করুন।':'আপনার ইন্টারনেট বিলের মেয়াদ শেষ। Apps ব্যবহার করতে, আপনার ইন্টারনেট বিল পরিশোধ করুন। ',textAlign: TextAlign.center,),
            SizedBox(height: 15,),
            Text('Bkash: 01913174775',textAlign: TextAlign.center,),
            SizedBox(height: 15,),
            ElevatedButton(onPressed: () async {
              await FirebaseAuth.instance.signOut();
            }, child: Text('Logout'))
          ],
        ),);}
  }
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 5), () => AlertMessage());
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _key,
      appBar: BaseAppBar(Userinfo: Userinfo,mykey: _key,),
      drawer: screenWidth < 800
          ? MyDrawer().SncDrawer(context: context, Userinfo: Userinfo, )
          : DrawerController(
              child: Text('data'), alignment: DrawerAlignment.start),
      body: LayoutBuilder(builder: (context, snapshot) {
        if (snapshot.maxWidth < 480) {
          return ListView(
            children: [
             UID=='G19JlJ5MQ1f5Manhp8eYelR85Sl1'?
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InputData(),
                        ));
                  },
                  child: Text('Input Data')):Container(),
              Slider(HeightSnc: 200.0,Userinfo: Userinfo,),
              Titlebar(TitleText: 'Category',Userinfo: Userinfo,),
              GridviewMovieTv(
                  Heightsnc: 300.0, type: "Cata", QueryData: 'Cata',Userinfo: Userinfo,),
              Titlebar(TitleText: 'Learning',Userinfo: Userinfo,),
              TopMovies(
                sncHeight: 200.0,
                type: 'Learning',
                Userinfo: Userinfo,
              ),
              Titlebar(TitleText: 'Islamic',Userinfo: Userinfo,),
              TopMovies(sncHeight: 200.0, CategoryName: 'Islamic',
                Userinfo: Userinfo,),
              Titlebar(TitleText: 'Live Tv',Userinfo: Userinfo,),
              GridviewMovieTv(Heightsnc: 300.0, type: 'tv',Userinfo: Userinfo,),
              Titlebar(TitleText: 'Cartoon',Userinfo: Userinfo,),
              TopMovies(sncHeight: 200.0, CategoryName: 'Cartoon',
                Userinfo: Userinfo,),
              Titlebar(TitleText: 'Playlist',Userinfo: Userinfo,
              ),
              TopMovies(
                sncHeight: 200.0,
                type: 'Playlist',

                Userinfo: Userinfo,
              ),
              Titlebar(
                TitleText: 'Movies',Userinfo: Userinfo,
              ),
              AllMovies(CrossAxisNum: 2,
                Userinfo: Userinfo,),
            ],
          );
        } else if (snapshot.maxWidth < 800) {
          //for tab
          return ListView(
            children: [
              UID=='G19JlJ5MQ1f5Manhp8eYelR85Sl1'?
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InputData(),
                        ));
                  },
                  child: Text('Input Data')):Container(),
              Slider(HeightSnc: 200.0,Userinfo: Userinfo,),
              Titlebar(TitleText: 'Category',Userinfo: Userinfo,),
              GridviewMovieTv(
                  Heightsnc: 300.0, type: "Cata", QueryData: 'Cata',Userinfo: Userinfo,
              ),
              Titlebar(TitleText: 'Learning',Userinfo: Userinfo,),
              TopMovies(
                sncHeight: 200.0,
                type: 'Learning',

                Userinfo: Userinfo,
              ),
              Titlebar(TitleText: 'Islamic',Userinfo: Userinfo,
              ),
              TopMovies(sncHeight: 200.0, CategoryName: 'Islamic',
                Userinfo: Userinfo,),
              Titlebar(TitleText: 'Live Tv',Userinfo: Userinfo,),
              GridviewMovieTv(Heightsnc: 300.0, type: 'tv',
              Userinfo: Userinfo,),
              Titlebar(TitleText: 'Cartoon',Userinfo: Userinfo,),
              TopMovies(sncHeight: 200.0, CategoryName: 'Cartoon',
                Userinfo: Userinfo,),
              Titlebar(TitleText: 'Playlist',Userinfo: Userinfo,),
              TopMovies(
                sncHeight: 200.0,
                type: 'Playlist',

                Userinfo: Userinfo,
              ),
              Titlebar(TitleText: 'Movies',Userinfo: Userinfo,),
              AllMovies(CrossAxisNum: 3,
                Userinfo: Userinfo,)
            ],
          );
        } else {
          return DesktopMode();
        }
      }),
      floatingActionButton: Redialmenu,
    );
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer();
  }

  Stack get Redialmenu {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          right: 0,
          child: RadialMenu(
              children: [
                RadialButton(
                  icon: Icon(Icons.call),
                  onPress: () => LuncherItems().launchURL('tel:+8801990976001'),
                  buttonColor: Colors.blue
                ),
                RadialButton(
                  icon: Icon(Icons.call),
                  onPress: () => LuncherItems().launchURL('tel:+8801863995432'),
                ),
                RadialButton(
                  buttonColor: Colors.blue,
                  icon: Icon(FontAwesomeIcons.facebookMessenger),
                  onPress: () => LuncherItems().launchURL('https://m.me/ShakilNetCorporation'),
                ),
                RadialButton(
                  buttonColor: Colors.green,
                  icon: Icon(FontAwesomeIcons.whatsapp),
                  onPress: () => LuncherItems().launchURL('https://wa.me/+8801863995432'),
                ),

              ]
          ),
        ),
      ],
    );
  }
}
class MyDrawer{
  Drawer SncDrawer({required context,required Userinfo})=> Drawer(
      child: Column(
        children: [
          SizedBox(
            height: 25,
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
            },
            leading: Icon(Icons.menu),
            title: Text('SNCorporation'),
          ),
          ListTile(
            title: Text('Home'),
            leading: Icon(Icons.home),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SncMain(),
                  ));
            },
          ),
          Expanded(flex: 9, child: MenuItem(Userinfo: Userinfo,)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Powered by'),
              TextButton(onPressed: () =>LuncherItems().launchURL('https://3tzk6dnkrez1ratymnroag-on.drv.tw/www.mywebsite.com/'), child: Text('Raihan Hossain'))
            ],
          )
        ],
      ),
    );
}

class DesktopMode extends StatelessWidget {
  final Userinfo;

  const DesktopMode({
    Key? key,this.Userinfo
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 2,
            child: Column(
              children: [
                ListTile(title: Text('Home'), leading: Icon(Icons.home)),
                Expanded(child: MenuItem(Userinfo: Userinfo,)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Powered by'),
                    TextButton(onPressed: () => LuncherItems().launchURL('https://3tzk6dnkrez1ratymnroag-on.drv.tw/www.mywebsite.com/'), child: Text('Raihan Hossain'))
                  ],
                )
              ],
            )),
        Expanded(
          flex: 8,
          child: ListView(
            children: [
              Slider(HeightSnc: 340.0,Userinfo: Userinfo,),
              Titlebar(TitleText: 'Category',Userinfo: Userinfo,),
              GridviewMovieTv(
                  Heightsnc: 350.0, type: "Cata", QueryData: 'Cata',Userinfo: Userinfo,),
              Titlebar(TitleText: 'Learning',Userinfo: Userinfo,),
              TopMovies(
                sncHeight: 200.0,
                type: 'Learning',

                Userinfo: Userinfo,
              ),
              Titlebar(TitleText: 'Islamic',Userinfo: Userinfo,),
              TopMovies(sncHeight: 200.0, CategoryName: 'Islamic',
                Userinfo: Userinfo,),
              Titlebar(TitleText: 'Live Tv',Userinfo: Userinfo,),
              GridviewMovieTv(Heightsnc: 350.0, type: 'tv',Userinfo: Userinfo,),
              Titlebar(TitleText: 'Cartoon',Userinfo: Userinfo,),
              TopMovies(sncHeight: 200.0, CategoryName: 'Cartoon',
                Userinfo: Userinfo,),
              Titlebar(TitleText: 'Playlist',Userinfo: Userinfo,),
              TopMovies(
                sncHeight: 200.0,
                type: 'Playlist',

                Userinfo: Userinfo,
              ),
              Titlebar(TitleText: 'Movies',Userinfo: Userinfo,),
              AllMovies(CrossAxisNum: 4,
                Userinfo: Userinfo,)
            ],
          ),
        ),
      ],
    );
  }
}

class MenuItem extends StatelessWidget {
  final Userinfo;


  CollectionReference usersStream =
      FirebaseFirestore.instance.collection('Category');

   MenuItem({Key? key, this.Userinfo,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: usersStream.orderBy('Category_Name', descending: false).get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return ListTile(
              onTap: () {
                if(data['type']=='webLink'){
                  LuncherItems().launchURL(data['WebsiteUrl']);
                }
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CataMovieList(
                        CategoryName: data['Category_Name'],
                        Userinfo: Userinfo,

                      ),
                    ));
              },
              leading: CircleAvatar(
                child: Image.network(data['IconSrc']),
              ),
              title: Text(data['Category_Name']),
            );
          }).toList(),
        );
      },
    );
  }
}

class AllMovies extends StatelessWidget {
  final CrossAxisNum;
  final UsingWhere;
  final QueryData;
  final Userinfo;


  AllMovies({Key? key, this.CrossAxisNum, this.UsingWhere, this.QueryData,required this.Userinfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MoviesData(
      QueryData: QueryData,
      CrossAxisNum: CrossAxisNum,
      UsingWhere: UsingWhere,

      Userinfo: Userinfo,
    );
  }
}

class MoviesData extends StatefulWidget {
  final CrossAxisNum;
  final UsingWhere;
  final QueryData;
  final Userinfo;


  const MoviesData(
      {Key? key, this.CrossAxisNum, this.UsingWhere, this.QueryData,required this.Userinfo,})
      : super(key: key);

  @override
  _MoviesDataState createState() => _MoviesDataState();
}

class _MoviesDataState extends State<MoviesData> {
  double Totalheight = 1000;
  @override
  Widget build(BuildContext context) {
    var Query = widget.QueryData == null
        ? FirebaseFirestore.instance
            .collection('All_Movies')
            .orderBy('Published', descending: true)
        : FirebaseFirestore.instance
            .collection('All_Movies')
            .where('Category_Name', arrayContainsAny: [widget.QueryData]);
    final Stream<QuerySnapshot> Movies = Query.snapshots();
    return Column(
      children: [
        SizedBox(
          height: Totalheight,
          child: StreamBuilder<QuerySnapshot>(
            stream: Movies,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }
              return GridView(
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: widget.CrossAxisNum),
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return InkWell(
                    onTap: () {
                      if (widget.UsingWhere == 'VideoPlayPage') {
                        Navigator.pop(context);
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SncVideoPlay(
                              MovieData: data,
                              Userinfo: widget.Userinfo,
                            ),
                          ));
                    },
                    child: MovieCard().buildCard(
                      bannersrc: data['BannerSrc'], name: data['MovieName'],publishedtime: data['Published'],TopCorner: Container()),
                  );
                }).toList(),
              );
            },
          ),
        ),
        ElevatedButton(
            onPressed: () {
              setState(() {
                Totalheight = Totalheight + 1000;
              });
            },
            child: Text(
              'Load More',
              textAlign: TextAlign.center,
            ))
      ],
    );
  }
}

class TopMovies extends StatelessWidget {
  final sncHeight;
  final mydata;
  final CategoryName;
  final type;
  final DocumentId;
  final Userinfo;



  TopMovies({this.sncHeight,
    this.mydata,
    this.DocumentId,
    this.CategoryName,
    this.type,
    required this.Userinfo,
    });

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> CasterInfo_get = type == null
        ? FirebaseFirestore.instance.collection('All_Movies').where(
        'Category_Name',
        arrayContainsAny: [CategoryName]).snapshots()
        : FirebaseFirestore.instance
        .collection('Learning_playlist')
        .where('Category', arrayContainsAny: [type])
        .snapshots();
    return SizedBox(
        height: sncHeight,
        child: StreamBuilder<QuerySnapshot>(
          stream: CasterInfo_get,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            return GridView(
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
              scrollDirection: Axis.horizontal,
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
                return InkWell(
                  onTap: () {
                    type == null
                        ? Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SncVideoPlay(
                                MovieData: data,

                                Userinfo: Userinfo,
                              ),
                        ))
                        : Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PlayListVideoPlay(
                                Banner_DocumentId: data,
                              ),
                        ));
                  },
                  child: MovieCard().buildCard(
                      bannersrc: data['BannerSrc'], name: data['MovieName'],publishedtime: '',TopCorner: Container()),
                );
              }).toList(),
            );
          },
        ));
  }
}

class Slider extends StatelessWidget {
  final HeightSnc;
  final Userinfo;


  Slider({Key? key, this.HeightSnc,required this.Userinfo,}) : super(key: key);
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('Slider_banner').snapshots();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: HeightSnc,
      child: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          final List<DocumentSnapshot> documents = snapshot.data!.docs;
          return CarouselSlider(
            items: documents.map((data) {
              return InkWell(
                  onTap: () {
                    if(data['Type'] == 'webLink'){
                      LuncherItems().launchURL(data['WebsiteUrl']);
                    }else {
                      data['Type'] == 'web'
                          ? Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                WebViewSnc(
                                  WebUrl: data['WebsiteUrl'],
                                  Userinfo: Userinfo,

                                ),
                          ))
                          : Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SncLiveTvPlay(
                                  VideoUrl: data['WebsiteUrl'],

                                  Userinfo: Userinfo,
                                ),
                          ));
                    }
                  },
                  child: Container(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        data['Movie_name'],
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            backgroundColor: Colors.black),
                      ),
                      height: HeightSnc,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(data['ImgSrc']),
                              fit: BoxFit.fitHeight))));
            }).toList(),
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 2.0,
              enlargeCenterPage: false,
              viewportFraction: 1.0,
            ),
          );
        },
      ),
    );
  }
}

class GridviewMovieTv extends StatelessWidget {
  final Heightsnc;
  final NumItem;
  final CrossAxisNum;
  final type;
  final ScroolDirection;
  final QueryData;


  final Userinfo;

  GridviewMovieTv(
      {Key? key,
      this.Heightsnc,
      this.NumItem,
      this.CrossAxisNum,
      this.type,
      this.ScroolDirection,
      this.QueryData,

      required this.Userinfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> Movies;
    if (QueryData == null) {
      Movies = FirebaseFirestore.instance
          .collection('tv_channel')
          .orderBy('name', descending: false)
          .snapshots();
    } else if (type == "Cata") {
      Movies = FirebaseFirestore.instance
          .collection('Category')
          .orderBy('Category_Name', descending: false)
          .snapshots();
    } else {
      Movies = FirebaseFirestore.instance
          .collection('tv_channel')
          .where('Category', arrayContainsAny: [QueryData]).snapshots();
    }
    return SizedBox(
      height: Heightsnc,
      child: StreamBuilder<QuerySnapshot>(
        stream: Movies,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return GridView(
            scrollDirection:
                ScroolDirection == null ? Axis.horizontal : Axis.vertical,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 15),
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return InkWell(
                  onTap: () {
                    if (ScroolDirection == 'vertical') {
                      Navigator.pop(context);
                    }
                    if (type == "tv") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SncLiveTvPlay(MovieData: data,
                                  Userinfo: Userinfo,),
                          ));
                    }
                  },
                  child: Card(
                    color: Colors.white,
                    child: type == "tv"
                        ? MovieCard().buildCard(
                        bannersrc: data['ImgSrc'], name: data['name'],publishedtime: '',TopCorner: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
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
                    ),)
                        : InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CataMovieList(
                                      CategoryName: data['Category_Name'],

                                      Userinfo: Userinfo,
                                    ),
                                  ));
                            },
                            child: Container(
                              child: type == "Cata"
                                  ? MovieCard().buildCard(
                                  bannersrc: data['IconSrc'], name: data['Category_Name'],publishedtime: '',TopCorner: Container())
                                  : Container(),
                            ),
                          ),
                  ));
            }).toList(),
          );
        },
      ),
    );
  }
}

class Titlebar extends StatelessWidget {
  final TitleText;
  final Userinfo;


  const Titlebar({Key? key, this.TitleText,required this.Userinfo,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.cyanAccent,
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            TitleText,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TitleText == 'Category' ||
                  TitleText == 'Movies' ||
                  TitleText == 'TV Channel'|| TitleText == 'Learning,Cartoon and Playlist'
              ? Container()
              : InkWell(
                  onTap: () {
                    if (TitleText == 'Live Tv') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SncLiveTvPlay(
                              VideoUrl:
                                  'http://tv.fanush.net/hls/andpictures.m3u8',
                              Userinfo: Userinfo,
                            ),
                          ));
                    } else if (TitleText == 'Islamic'||TitleText == 'Cartoon') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CataMovieList(
                              CategoryName: TitleText,
                              Userinfo: Userinfo,
                            ),
                          ));
                    }
                  },
                  child: Text(
                    'View all >>',
                    style: TextStyle(color: Colors.purple),
                  ),
                )
        ],
      ),
    );
  }
}
