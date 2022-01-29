import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'basic_home_signin_signup/signin.dart';

class SncMyprofile extends StatefulWidget {
  const SncMyprofile({Key? key}) : super(key: key);

  @override
  _SncMyprofileState createState() => _SncMyprofileState();
}

class _SncMyprofileState extends State<SncMyprofile> {
  CollectionReference usersStream =
  FirebaseFirestore.instance.collection('User');
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
  @override
  Widget build(BuildContext context) {
    var Screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: FutureBuilder<QuerySnapshot>(
        future: usersStream.where('uid',isEqualTo: UID).get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return Column(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
              document.data()! as Map<String, dynamic>;
              return SizedBox(
                height: Screenheight,
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      expandedHeight: 400,
                      flexibleSpace: FlexibleSpaceBar(
                        title: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(data['ImgSrc']),
                            ),
                            SizedBox(width: 10,),
                            Text(data['Name']),
                          ],
                        ),

                        background: Image.network(data['BackgroudImage']),
                      ),
                    ),
                    SliverFillRemaining(
                      child: Center(
                        child: Text('please wait for new update'),
                      ),
                    )
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
