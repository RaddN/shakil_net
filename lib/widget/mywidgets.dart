import 'package:finaltestfirebase/SearchPage.dart';
import 'package:finaltestfirebase/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget{
final mykey;
final Userinfo;

  const BaseAppBar({this.mykey, this.Userinfo});
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var dropdowntext = 4;
    return AppBar(
      leading: screenWidth < 800
          ? IconButton(
          onPressed: () {
            mykey.currentState!.openDrawer();
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
                      builder: (context) => SearchPage(
                        Userinfo: Userinfo,
                      ),
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
                  backgroundImage: NetworkImage(Userinfo==null?'': Userinfo['ImgSrc']),
                ),
                value: 4,
              ),
              DropdownMenuItem(
                child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context, CupertinoPageRoute(builder: (context) => SncMyprofile(Userinfo: Userinfo,),));
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
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => new Size.fromHeight(60);
}

class MovieCard {
  Card buildCard({bannersrc,name,publishedtime,required TopCorner}) {
    return Card(
      color: Colors.grey,
      child: Column(
        children: [
          TopCorner,
          Expanded(flex: 8, child: Padding(
            padding: const EdgeInsets.only(left: 8.0,right: 8.0),
            child: Image.network(bannersrc),
          )),
          Expanded(flex: 2, child: ListView(
            children: [
              Text(
                name, textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white),
              ),
              Text(publishedtime,textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white))
            ],
          ),),
        ],
      ),
    );
  }
}

class LuncherItems{
  void launchURL(_url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }
}
