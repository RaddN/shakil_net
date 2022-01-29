import 'dart:async';
import 'package:flutter/material.dart';
import '../main.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';
class SncSplashScreen extends StatefulWidget {
  const SncSplashScreen({Key? key}) : super(key: key);

  @override
  _SncSplashScreenState createState() => _SncSplashScreenState();
}

class _SncSplashScreenState extends State<SncSplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 4), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SncMain(),));
    });
  }
  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SvgPicture.asset(screenwidth<480?'assets/svg/Splash Screen.svg':'assets/svg/Splashscreenbigscreen.svg',width: screenwidth,),
    );
  }
}