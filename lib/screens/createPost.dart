import 'package:authentification/bookInfo.dart';
import 'package:authentification/database.dart';
import 'package:authentification/screens/add_review.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../search_widget.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  Widget bookCard(BuildContext context, int index) {
    //final book = BookList[index];
    return Container(
      decoration: BoxDecoration(
          color: HexColor("D0ECEC"),
          border: Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.all(Radius.circular(15))),
      height: 172,
      width: 369,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                Container(
                  width: 79,
                  height: 124,
                  child: Image(
                    image: NetworkImage(Database.books[index]['Image_url']),
                    fit: BoxFit.fill,
                  ),
                  //add image here
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 220,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            Database.books[index]['Title']
                                .toString()
                                .toUpperCase(),
                            overflow: TextOverflow.fade,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 5, bottom: 10),
                          child: Text(
                            Database.books[index]['Author']
                                .toString()
                                .toUpperCase(),
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          )),
                      Container(
                        height: 25,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: HexColor("3C9197"),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text("Add review"),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AddReview(
                                      bookCode: Database.books[index]
                                          ['isbn'])));
                            }),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            Database.books[index]['Review_count'].toString() +
                                " reviews have been posted",
                            style: TextStyle(
                                fontSize: 12, color: HexColor("2E979D")),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildSearch() => SearchWidget(text: 'none', hintText: 'Find book');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Select a book to review',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
          child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            buildSearch(),
            Container(
              height: 560,
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                padding: EdgeInsets.all(10),
                itemCount: Database.books.length,
                itemBuilder: (BuildContext context, int index) {
                  return bookCard(context, index);
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}
