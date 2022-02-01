
import 'package:finaltestfirebase/main.dart';
import 'package:flutter/material.dart';

import 'signin.dart';
import 'signup.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 7,
            child: Container(
              alignment: Alignment.center,
              child: MainLogo(myHeight: 120,),
            ),
          ),
          SizedBox(height: 15,),
          Expanded(flex: 3,
              child: Column(
            children: [
              SingButton(myText: 'Sign in',myLinknum: 0,myColornum: 0,),
              SizedBox(height: 15,),
              SingButton(myText: 'Sign up', myLinknum: 1,myColornum: 0,),
              SizedBox(height: 15,),
            ],
              ))
        ],
      ),
    );
  }
}

class MainLogo extends StatelessWidget {
 final double myHeight;

   MainLogo({Key? key, required this.myHeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text('Shakil Net Corporation',style: TextStyle(
        fontSize: 25
      ),),
      Text('Login')
    ],
            );
  }
}

class SingButton extends StatelessWidget {
final String myText;
final int myLinknum;
final int myColornum;
final onClick;


SingButton({required this.myText, required this.myLinknum,required this.myColornum,this.onClick});
  List myLink = [

SignUp(),
  ];
  List MyColor = [
    Colors.white,
    Colors.blue,
    Colors.white,
  ];
  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: () {
      if(onClick==null){
      Navigator.push(context, MaterialPageRoute(builder: (context) => myLink[myLinknum],));}
      else{
        onClick;
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SncMain(),));
      }
    }, child: Text(myText,style: TextStyle(color: MyColor[myColornum+1]),), style: ButtonStyle(
     backgroundColor: MaterialStateProperty.all(MyColor[myColornum]),
      padding: MaterialStateProperty.all(EdgeInsets.only(left: 200,right: 200,top: 18, bottom: 18)),
      textStyle: MaterialStateProperty.all(TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,

      ))
    ),);
  }
}
