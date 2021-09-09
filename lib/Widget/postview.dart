import 'package:authentification/Models/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hexcolor/hexcolor.dart';

class ViewPostScreen extends StatefulWidget {
  final String code;
  const ViewPostScreen({Key? key, required this.code}) : super(key: key);
  @override
  _ViewPostScreenState createState() => _ViewPostScreenState();
}

class _ViewPostScreenState extends State<ViewPostScreen> {
  Color likeIcon = Colors.grey;
  Widget Comment(BuildContext context, int index) {
    return Container(
        child: Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: CircleAvatar(
            backgroundColor: Colors.black,
            radius: 18,
            child: CircleAvatar(
              //import image
              radius: 17,
              backgroundImage: null,
              backgroundColor: HexColor("41BEC5"),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.black12,
              border: Border.all(color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Who',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('content'),
            ],
          ),
        )
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    int index = Database.posts
        .indexWhere((element) => element['postId'] == widget.code);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            Database.posts[index]['Owner'],
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: SingleChildScrollView(
            child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(10),
          alignment: Alignment.topCenter,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(15),
                height: 450,
                color: HexColor("BFE8E8"),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: CircleAvatar(
                              child: CircleAvatar(
                                  //backgroundImage: Database.posts[index]['postID'].toString().,
                                  ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  Database.posts[index]['Owner'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: <Widget>[
                                    // Text(DateTime.now()
                                    //         .difference(
                                    //             Database.posts[index]['time'])
                                    //         .inMinutes
                                    //         .toString() +
                                    //     " m"),
                                    Text(Database.posts[index]['time']),
                                    Icon(Icons.timer)
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(top: 20, bottom: 50),
                      child: MarkdownBody(
                        data: Database.posts[index]['Content'],
                        fitContent: true,
                        // style: TextStyle(fontFamily: 'Rasa', fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        IconButton(
                            onPressed: () {
                              setState(() {
                                if (likeIcon == Colors.grey) {
                                  likeIcon = Colors.blue;
                                  //TODO: count up
                                  //Database.posts[index]['Like_count'];
                                } else {
                                  likeIcon = Colors.grey;
                                  //TODO: count down
                                  // if (Database.posts[index]['Like_count'] > 0) {
                                  //   Database.posts[index]['Like_count']--;
                                  // }
                                }
                              });
                            },
                            icon: Icon(
                              Icons.thumb_up,
                              color: likeIcon,
                            )),
                        Container(
                            child: Text(
                                Database.posts[index]['Like_count'].toString() +
                                    " likes")),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.comment,
                              color: Colors.grey,
                            )),
                        Container(
                            child: Text(Database.posts[index]['Comment_count']
                                    .toString() +
                                " comments"))
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.only(top: 0, bottom: 5),
                  height: 150,
                  child: ListView.separated(
                      itemBuilder: (BuildContext context, int index) {
                        return Comment(context, index);
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                      itemCount: Database.posts[index]['Comment_count'])),
              Container(
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {},
                      ),
                      hintText: 'Leave commment ...',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                ),
              ),
            ],
          ),
        )));
  }
}
