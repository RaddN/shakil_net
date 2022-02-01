import 'package:finaltestfirebase/widget/mywidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class CataMovieList extends StatefulWidget {
  final CategoryName;
  final Userinfo;
   CataMovieList({Key? key, this.CategoryName,required this.Userinfo}) : super(key: key);
  @override
  State<CataMovieList> createState() => _CataMovieListState();
}

class _CataMovieListState extends State<CataMovieList> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  var dropdowntext =4;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _key,
      appBar: BaseAppBar(Userinfo: widget.Userinfo,mykey: _key,),
      drawer:screenWidth<800? MyDrawer().SncDrawer(context: context, Userinfo: widget.Userinfo, ):DrawerController(child: Text('data'), alignment: DrawerAlignment.start),
      body:screenWidth < 480?ListView(children: [AllMovies(CrossAxisNum:2,QueryData: widget.CategoryName,
        Userinfo: widget.Userinfo,)],):screenWidth < 800?ListView(children: [AllMovies(CrossAxisNum:3,QueryData: widget.CategoryName,
        Userinfo: widget.Userinfo,)],):Row(
        children: [
          Expanded(
              flex: 2,
              child: MenuItem(

                Userinfo: widget.Userinfo,
              )

          ),
          Expanded(flex: 8, child: AllMovies(CrossAxisNum:4,QueryData: widget.CategoryName,
            Userinfo: widget.Userinfo,)),
        ],
      ),
    );
  }
}
