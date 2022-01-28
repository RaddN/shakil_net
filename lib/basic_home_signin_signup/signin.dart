
import 'package:finaltestfirebase/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class SingIn extends StatefulWidget {
  const SingIn({Key? key}) : super(key: key);

  @override
  _SingInState createState() => _SingInState();
}

class _SingInState extends State<SingIn> {
  final Email = TextEditingController();
  final Password = TextEditingController();
  var showallert='';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {

      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SncMain(),));
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(flex: 3,
              child: Container(
            alignment: Alignment.center,
            color: Colors.blue,
            child: MainLogo(myHeight: 120,)
          )),
          Expanded(flex: 7,
              child: Column(
                children: [
                  SizedBox(height: 15,),
                 Padding(
                   padding: const EdgeInsets.only(right: 10.0),
                   child: TextFormField(
                     controller: Email,
                   decoration: InputDecoration(
                     hintText: 'Email/phone number/Userid',
                     icon: Icon(Icons.alternate_email_outlined),
                     border: OutlineInputBorder(),
                     contentPadding: EdgeInsets.only(right: 15,left: 15),
                   ),
                   ),
                 ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: TextFormField(
                      controller: Password,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        icon: Icon(Icons.vpn_key_sharp),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.only(right: 15,left: 15),
                      ),
                      obscureText: true,
                    ),
                  ),
                  Text(showallert.toString()),
                  SizedBox(height: 10,),
                  ElevatedButton(onPressed: () async {
                    try {
                      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: '${Email.text}@shakilnet.com',
                          password: Password.text
                      );
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        setState(() {
                          showallert = 'No user found for that email.';
                        });
                      } else if (e.code == 'wrong-password') {
                        setState(() {
                          showallert = 'Wrong password provided for that user.';
                        });
                      }
                    }
                  }, child: Text('Login'))
                ],
          ))
        ],
      ),
    );
  }
}
