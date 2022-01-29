import 'package:finaltestfirebase/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'main.dart';

class CataMovieList extends StatefulWidget {
  final CategoryName;

  const CataMovieList({Key? key, this.CategoryName}) : super(key: key);
  @override
  State<CataMovieList> createState() => _CataMovieListState();
}

class _CataMovieListState extends State<CataMovieList> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  var showsearchbar = false;
  var dropdowntext =4;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _key,
      appBar: AppBar(
        leading:screenWidth<800? IconButton(onPressed: () {
          _key.currentState!.openDrawer();
        }, icon: Icon(Icons.menu)):Container(),
        title: showsearchbar==false? Text('SNCorporation'):Container(
          height: 40,
          child: TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white,width: 0),borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              suffixIcon: Icon(Icons.search,color: Colors.white,),
            ),
          ),
        ),
        actions: [
          if(screenWidth<800) IconButton(onPressed: () {
            setState(() {
              showsearchbar =! showsearchbar;
            });
          }, icon:showsearchbar == false? Icon(Icons.search):Icon(FontAwesomeIcons.times,color: Colors.black,)),

          IconButton(onPressed: () {

          }, icon: Icon(Icons.notifications)),
          SizedBox(width: 20,),
          DropdownButton(
              iconSize: 0.0,
              underline: Container(),
              value: dropdowntext,
              onChanged: (value) {

              },
              // onTap: () {
              //   Navigator.push(context, MaterialPageRoute(builder: (context) => SncMyprofile(),));
              // },
              items: [
                DropdownMenuItem(child: CircleAvatar(
                  backgroundImage: NetworkImage('https://images.pexels.com/photos/2662116/pexels-photo-2662116.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                ),value: 4,),
                DropdownMenuItem(
                  child: GestureDetector(
                      onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, CupertinoPageRoute(builder: (context) => SncMyprofile(),));
                  }, child: Text('Profile')),value: 1,),
                DropdownMenuItem(
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                  },
                  child: Text('Logout'),value: 3,),


              ]),
        ],
      ),
      drawer:screenWidth<800?Drawer(
        child: Column(
          children: [
            ListTile(
              onTap: () {
                Navigator.pop(context);
              },
              leading: Icon(Icons.menu),
              title: Text('SNCorporation'),
            ),
            ListTile(title: Text('Home'),leading: Icon(Icons.home),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => SncMain(),));
              },),
            Expanded(flex: 9, child: MenuItem())
          ],
        ),
      ):DrawerController(child: Text('data'), alignment: DrawerAlignment.start),
      body:screenWidth < 480?ListView(children: [AllMovies(CrossAxisNum:2,QueryData: widget.CategoryName)],):screenWidth < 800?ListView(children: [AllMovies(CrossAxisNum:3,QueryData: widget.CategoryName)],):Row(
        children: [
          Expanded(
              flex: 2,
              child: MenuItem()

          ),
          Expanded(flex: 8, child: AllMovies(CrossAxisNum:4,QueryData: widget.CategoryName)),
        ],
      ),
    );
  }
}
