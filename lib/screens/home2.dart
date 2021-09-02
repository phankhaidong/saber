import 'package:authentification/database.dart';
import 'package:authentification/rating.dart';
import 'package:authentification/search_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _controller;
  late TextEditingController _textEditingController;
  TextStyle style = TextStyle(color: Colors.black, fontSize: 24);
  Widget buildSearch() =>
      SearchWidget(text: 'none', hintText: 'Find book, author, tags,...');
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    _textEditingController = TextEditingController();
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
              // Text(DateTime.now()
              //         .difference(posts[index]['time'].runtimeType())
              //         .inMinutes
              //         .toString() +
              //     'm'),

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
                  onPressed: () {})
            ],
          ),
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: HexColor('E1F0ED'),
            child: Column(children: <Widget>[
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
              TabBar(controller: _controller, tabs: [
                Tab(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: HexColor('26B5BE'),
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    width: 137,
                    height: 40,
                    child: Text(
                      'Trending',
                      style: style,
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: HexColor('26B5BE'),
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    width: 137,
                    height: 40,
                    child: Text(
                      'Now',
                      style: style,
                    ),
                  ),
                ),
              ]),
              Divider(
                color: Colors.grey,
              ),
              TabBarView(controller: _controller, children: [
                Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          "Tredning posts",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
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
              ])
            ])));
  }
}
