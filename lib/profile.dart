import 'package:flutter/material.dart';

class SncMyprofile extends StatefulWidget {
 final Userinfo;

  const SncMyprofile({Key? key, this.Userinfo}) : super(key: key);

  @override
  _SncMyprofileState createState() => _SncMyprofileState();
}

class _SncMyprofileState extends State<SncMyprofile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 400,
            flexibleSpace: FlexibleSpaceBar(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.Userinfo==null?'': widget.Userinfo['ImgSrc']),
                  ),
                  SizedBox(width: 10,),
                  Text(widget.Userinfo==null?'':widget.Userinfo['Name']),
                ],
              ),

              background: Image.network(widget.Userinfo==null?'':widget.Userinfo['BackgroudImage']),
            ),
          ),
          SliverFillRemaining(
            child: Center(
              child: Text('please wait for new update'),
            ),
          )
        ],
      )

    );
  }
}
