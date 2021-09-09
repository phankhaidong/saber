import 'dart:async';

import 'package:authentification/Models/database.dart';
import 'package:authentification/screens/add_review.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SearchWidget1 extends StatefulWidget {
  const SearchWidget1({
    Key? key,
  }) : super(key: key);

  @override
  _SearchWidget1State createState() => _SearchWidget1State();
}

class _SearchWidget1State extends State<SearchWidget1> {
  TextEditingController _searchController = TextEditingController();
  late Future resultsLoaded;
  List _allResults = [];
  List _resultsList = [];
  searchResultsList() {
    var showResults = [];

    if (_searchController.text != "") {
      for (var tripSnapshot in _allResults) {
        var title = tripSnapshot['Title'].toString().toLowerCase();

        if (title.contains(_searchController.text.toLowerCase())) {
          showResults.add(tripSnapshot);
        }
      }
    } else {
      showResults = List.from(_allResults);
    }
    setState(() {
      _resultsList = showResults;
    });
  }

  getUsersPastTripsStreamSnapshots() async {
    setState(() {
      _allResults = Database.books;
    });
    searchResultsList();
    return "complete";
  }

  _onSearchChanged() {
    searchResultsList();
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resultsLoaded = getUsersPastTripsStreamSnapshots();
  }

  Widget bookCard(BuildContext context, int index) {
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
                    image: NetworkImage(_resultsList[index]['Image_url']),
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
                            _resultsList[index]['Title']
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
                            _resultsList[index]['Author']
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
                                      bookCode: _resultsList[index]['isbn'])));
                            }),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            _resultsList[index]['Review_count'].toString() +
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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 650,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                icon: Icon(Icons.search, color: Colors.black),
                hintText: 'Find book',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
          Expanded(
              child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  padding: EdgeInsets.all(10),
                  itemCount: _resultsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return bookCard(context, index);
                  })),
        ],
      ),
    );
  }
}
