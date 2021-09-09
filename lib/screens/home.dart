import 'package:authentification/Models/database.dart';
import 'package:authentification/Widget/postview.dart';
import 'package:authentification/Widget/rating.dart';
import 'package:authentification/Widget/search_widget.dart';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget buildSearch() =>
      SearchWidget(text: 'none', hintText: 'Find book, author, tags,...');
  //List posts = [];
  void initState() {
    super.initState();
    //Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
  }

  Widget postCard(BuildContext context, int index) {
    return GestureDetector(
        child: Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      height: 250,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.watch_later,
                size: 18,
                color: Colors.grey,
              ),
              Expanded(child: Text(Database.posts[index]['time'])),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 10, bottom: 10),
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: null,
                  backgroundColor: HexColor("41BEC5"),
                ),
              ),
              Expanded(
                child: RichText(
                    text: TextSpan(
                        text: Database.posts[index]['Owner'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                        children: [
                      TextSpan(
                          text: " posted a review in ",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal)),
                      TextSpan(
                        text: Database.books[Database.books.indexWhere(
                                (element) =>
                                    element['isbn'] ==
                                    Database.posts[index]['ISBN'].toString())]
                            ['Title'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      TextSpan(
                          text: " by ",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal)),
                      TextSpan(
                        text: Database.books[Database.books.indexWhere(
                            (element) =>
                                element['isbn'] ==
                                Database.posts[index]['ISBN'])]['Author'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ])),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 60,
                  height: 87,
                  //add image here
                  child: Image(
                      fit: BoxFit.fill,
                      image: NetworkImage(Database.books[Database.books
                          .indexWhere((element) =>
                              element['isbn'] ==
                              Database.posts[index]['ISBN'])]['Image_url'])),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        Database.books[Database.books.indexWhere((element) =>
                            element['isbn'] ==
                            Database.posts[index]['ISBN'])]['Title'],
                        //Database.books[posts[index]['ISBN']]['Title'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(
                          "By " +
                              Database.books[Database.books.indexWhere(
                                  (element) =>
                                      element['isbn'] ==
                                      Database.posts[index]['ISBN'])]['Author'],
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      Container(
                        height: 25,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: HexColor("3C9197"),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text("Add to library"),
                            onPressed: () {}),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Rate this book: ",
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 15),
                            ),
                            Rating((rating) {
                              //posts[index].rate = rating;
                            }, 5),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                  child: Text('View post',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: HexColor("207D83"))),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ViewPostScreen(
                            code: Database.posts[index]['postId'])));
                  })
            ],
          ),
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageUI(),
    );
  }

  Widget pageUI() {
    return Scaffold(
        body: Container(
      color: HexColor('E1F0ED'),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 50, 0, 0),
                      child: Text(
                        'Reybo',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'publicsans',
                            fontWeight: FontWeight.bold,
                            fontSize: 23),
                      ),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(260, 0, 0, 0)),
                    CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 23,
                      child: CircleAvatar(
                        //import image
                        radius: 22,
                        backgroundImage: null,
                        backgroundColor: HexColor("41BEC5"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            buildSearch(),
            Padding(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                      width: 137,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          side: BorderSide(width: 1.0, color: Colors.black),
                          primary: HexColor('26B5BE'),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Trending',
                          style: TextStyle(fontSize: 24),
                        ),
                        onPressed: () {},
                      )),
                  Container(
                      width: 137,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          side: BorderSide(width: 1.0, color: Colors.black),
                          primary: HexColor('26B5BE'),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'New',
                          style: TextStyle(fontSize: 24),
                        ),
                        onPressed: () {},
                      )),
                ],
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            Row(
              children: [
                Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "Tredning posts",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ))
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: 5),
              height: 500,
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                padding: EdgeInsets.all(15),
                itemCount: Database.posts.length,
                itemBuilder: (BuildContext context, int index) {
                  return postCard(context, index);
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
