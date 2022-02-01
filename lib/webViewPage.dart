import 'package:finaltestfirebase/widget/mywidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';


import 'main.dart';

class WebViewSnc extends StatefulWidget {
  final WebUrl;
  final Userinfo;
  const WebViewSnc({Key? key, this.WebUrl,required this.Userinfo}) : super(key: key);


  @override
  _WebViewSncState createState() => _WebViewSncState();
}

class _WebViewSncState extends State<WebViewSnc> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  var showsearchbar = false;
  var dropdowntext =4;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _key,
      appBar: BaseAppBar(Userinfo: widget.Userinfo,mykey: _key,),
      drawer:screenWidth<800? MyDrawer().SncDrawer(context: context, Userinfo: widget.Userinfo,):DrawerController(child: Text('data'), alignment: DrawerAlignment.start),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse(widget.WebUrl)),
      ),
    );
  }
}
