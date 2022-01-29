import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finaltestfirebase/SearchPage.dart';
import 'package:finaltestfirebase/catamovielist.dart';
import 'package:finaltestfirebase/inputdata.dart';
import 'package:finaltestfirebase/profile.dart';
import 'package:finaltestfirebase/sncvideoplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SingIn(),));
      } else {
        setState(() {
          UID = user.uid;
        });
      }
    });
  }
  void _launchURL(_url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _key,
      appBar: AppBar(
        leading: screenWidth < 800
            ? IconButton(
                onPressed: () {
                  _key.currentState!.openDrawer();
                },
                icon: Icon(Icons.menu))
            : Container(),
        title: Text('SNCorporation'),
        actions: [
          if (screenWidth < 800)
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchPage(),
                      ));
                },
                icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
          SizedBox(
            width: 20,
          ),
          DropdownButton(
              iconSize: 0.0,
              underline: Container(),
              value: dropdowntext,
              onChanged: (value) {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen(),));
              },
              items: [
                DropdownMenuItem(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://images.pexels.com/photos/2662116/pexels-photo-2662116.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                  ),
                  value: 4,
                ),
                DropdownMenuItem(
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(context, CupertinoPageRoute(builder: (context) => SncMyprofile(),));
                      }, child: Text('Profile')),
                  value: 1,
                ),
                DropdownMenuItem(
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                  },
                  child: Text('Logout'),
                  value: 3,
                ),
              ]),
        ],
      ),
      drawer: screenWidth < 800
          ? Drawer(
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
                  Expanded(flex: 9, child: MenuItem()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Powered by'),
                      TextButton(onPressed: () => _launchURL('https://3tzk6dnkrez1ratymnroag-on.drv.tw/www.mywebsite.com/'), child: Text('Raihan Hossain'))
                    ],
                  )
                ],
              ),
            )
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
              Slider(HeightSnc: 200.0),
              Titlebar(TitleText: 'Category'),
              GridviewMovieTv(
                  Heightsnc: 300.0, type: "Cata", QueryData: 'Cata'),
              Titlebar(TitleText: 'Learning'),
              TopMovies(
                sncHeight: 200.0,
                type: 'Learning',
              ),
              Titlebar(TitleText: 'Islamic'),
              TopMovies(sncHeight: 200.0, CategoryName: 'Islamic'),
              Titlebar(TitleText: 'Live Tv'),
              GridviewMovieTv(Heightsnc: 300.0, type: 'tv'),
              Titlebar(TitleText: 'Cartoon'),
              TopMovies(sncHeight: 200.0, CategoryName: 'Cartoon'),
              Titlebar(TitleText: 'Playlist'),
              TopMovies(
                sncHeight: 200.0,
                type: 'Playlist',
              ),
              Titlebar(
                TitleText: 'Movies',
              ),
              AllMovies(CrossAxisNum: 2),
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
              Slider(HeightSnc: 200.0),
              Titlebar(TitleText: 'Category'),
              GridviewMovieTv(
                  Heightsnc: 300.0, type: "Cata", QueryData: 'Cata'),
              Titlebar(TitleText: 'Learning'),
              TopMovies(
                sncHeight: 200.0,
                type: 'Learning',
              ),
              Titlebar(TitleText: 'Islamic'),
              TopMovies(sncHeight: 200.0, CategoryName: 'Islamic'),
              Titlebar(TitleText: 'Live Tv'),
              GridviewMovieTv(Heightsnc: 300.0, type: 'tv'),
              Titlebar(TitleText: 'Cartoon'),
              TopMovies(sncHeight: 200.0, CategoryName: 'Cartoon'),
              Titlebar(TitleText: 'Playlist'),
              TopMovies(
                sncHeight: 200.0,
                type: 'Playlist',
              ),
              Titlebar(TitleText: 'Movies'),
              AllMovies(CrossAxisNum: 3)
            ],
          );
        } else {
          return DesktopMode();
        }
      }),
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            child: RadialMenu(
                children: [
                  RadialButton(
                    icon: Icon(Icons.call),
                    onPress: () => _launchURL('tel:+8801990976001'),
                    buttonColor: Colors.blue
                  ),
                  RadialButton(
                    icon: Icon(Icons.call),
                    onPress: () => _launchURL('tel:+8801863995432'),
                  ),
                  RadialButton(
                    buttonColor: Colors.blue,
                    icon: Icon(FontAwesomeIcons.facebookMessenger),
                    onPress: () => _launchURL('https://m.me/ShakilNetCorporation'),
                  ),
                  RadialButton(
                    buttonColor: Colors.green,
                    icon: Icon(FontAwesomeIcons.whatsapp),
                    onPress: () => _launchURL('https://wa.me/+8801863995432'),
                  ),

                ]
            ),
          ),
        ],
      ),
    );
  }
}

class DesktopMode extends StatelessWidget {
  const DesktopMode({
    Key? key,
  }) : super(key: key);
  void _launchURL(_url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 2,
            child: Column(
              children: [
                ListTile(title: Text('Home'), leading: Icon(Icons.home)),
                Expanded(child: MenuItem()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Powered by'),
                    TextButton(onPressed: () => _launchURL('https://3tzk6dnkrez1ratymnroag-on.drv.tw/www.mywebsite.com/'), child: Text('Raihan Hossain'))
                  ],
                )
              ],
            )),
        Expanded(
          flex: 8,
          child: ListView(
            children: [
              Slider(HeightSnc: 340.0),
              Titlebar(TitleText: 'Category'),
              GridviewMovieTv(
                  Heightsnc: 350.0, type: "Cata", QueryData: 'Cata'),
              Titlebar(TitleText: 'Learning'),
              TopMovies(
                sncHeight: 200.0,
                type: 'Learning',
              ),
              Titlebar(TitleText: 'Islamic'),
              TopMovies(sncHeight: 200.0, CategoryName: 'Islamic'),
              Titlebar(TitleText: 'Live Tv'),
              GridviewMovieTv(Heightsnc: 350.0, type: 'tv'),
              Titlebar(TitleText: 'Cartoon'),
              TopMovies(sncHeight: 200.0, CategoryName: 'Cartoon'),
              Titlebar(TitleText: 'Playlist'),
              TopMovies(
                sncHeight: 200.0,
                type: 'Playlist',
              ),
              Titlebar(TitleText: 'Movies'),
              AllMovies(CrossAxisNum: 4)
            ],
          ),
        ),
      ],
    );
  }
}

class MenuItem extends StatelessWidget {
  CollectionReference usersStream =
      FirebaseFirestore.instance.collection('Category');
  void _launchURL(_url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }
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
                  _launchURL(data['WebsiteUrl']);
                }
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CataMovieList(
                        CategoryName: data['Category_Name'],
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
  AllMovies({Key? key, this.CrossAxisNum, this.UsingWhere, this.QueryData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MoviesData(
      QueryData: QueryData,
      CrossAxisNum: CrossAxisNum,
      UsingWhere: UsingWhere,
    );
  }
}

class MoviesData extends StatefulWidget {
  final CrossAxisNum;
  final UsingWhere;
  final QueryData;

  const MoviesData(
      {Key? key, this.CrossAxisNum, this.UsingWhere, this.QueryData})
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
                            ),
                          ));
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
                            Text(data['Published'],
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
  TopMovies(
      {this.sncHeight,
      this.mydata,
      this.DocumentId,
      this.CategoryName,
      this.type});
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
                              builder: (context) => SncVideoPlay(
                                MovieData: data,
                              ),
                            ))
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlayListVideoPlay(
                                Banner_DocumentId: data,
                              ),
                            ));
                  },
                  child: Card(
                    color: Colors.grey,
                    child: Column(
                      children: [
                        Expanded(flex: 8, child: Image.network(data['BannerSrc'])),
                        SizedBox(height: 10,),
                        Expanded(flex: 2, child: Text(
                          data['MovieName'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12),
                        ),),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ));
  }
}

class Slider extends StatelessWidget {
  final HeightSnc;

  Slider({Key? key, this.HeightSnc}) : super(key: key);
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('Slider_banner').snapshots();
  void _launchURL(_url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }

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
                      _launchURL(data['WebsiteUrl']);
                    }else {
                      data['Type'] == 'web'
                          ? Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                WebViewSnc(
                                  WebUrl: data['WebsiteUrl'],
                                ),
                          ))
                          : Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SncLiveTvPlay(
                                  VideoUrl: data['WebsiteUrl'],
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

  GridviewMovieTv(
      {Key? key,
      this.Heightsnc,
      this.NumItem,
      this.CrossAxisNum,
      this.type,
      this.ScroolDirection,
      this.QueryData})
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
                                SncLiveTvPlay(MovieData: data),
                          ));
                    }
                  },
                  child: Card(
                    color: Colors.white,
                    child: type == "tv"
                        ? Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          )
                        : InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CataMovieList(
                                      CategoryName: data['Category_Name'],
                                    ),
                                  ));
                            },
                            child: Container(
                              child: type == "Cata"
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                            width: 80.0,
                                            child:
                                                Image.network(data['IconSrc'])),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(data['Category_Name'])
                                      ],
                                    )
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
  const Titlebar({Key? key, this.TitleText}) : super(key: key);
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
                  TitleText == 'TV Channel'
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
                            ),
                          ));
                    } else if (TitleText == 'Islamic'||TitleText == 'Cartoon') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CataMovieList(
                              CategoryName: TitleText,
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
