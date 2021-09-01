import 'package:authentification/database.dart';
import 'package:authentification/reybo_app_icons.dart';
import 'package:authentification/screens/setting.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //List<bool> _selections = List.generate(2, (_) => false);
  Widget _buildScreen() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
              color: HexColor("A0EDED"),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 45,
                    child: CircleAvatar(
                      radius: 44,
                      backgroundImage:
                          NetworkImage(Database.thisUserInfo.Image),
                      backgroundColor: HexColor("BFE8E8"),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        Database.thisUserInfo.Works.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      Text(
                        'WORKS',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        Database.thisUserInfo.Follower_count.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      Text(
                        'FOLLOWERS',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        Database.thisUserInfo.Following_count.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      Text(
                        'FOLLOWING',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              )),
          Container(
            padding: EdgeInsets.fromLTRB(30, 5, 0, 0),
            color: HexColor("A0EDED"),
            child: Row(
              children: <Widget>[
                Text(
                  Database.thisUserInfo.Fullname, //get user name
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'PublicSans',
                  ),
                )
              ],
            ),
          ),
          Container(
            color: HexColor("A0EDED"),
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: Colors.white,
                      minimumSize: Size(165, 27),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide(width: 0.5, color: Colors.grey),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Introduction',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: Colors.white,
                      minimumSize: Size(165, 27),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide(width: 0.5, color: Colors.grey),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Active',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          Row(children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
              child:
                  Text(Database.thisUserInfo.About), // get descritp form user
            ),
          ]),
          Divider(
            color: Colors.grey,
          ),
          //build list view for post
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: HexColor("A0EDED"),
        actions: [
          IconButton(
              icon: Icon(ReyboApp.setting),
              color: HexColor("C4C4C4"),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Setting()));
              })
        ],
      ),
      body: _buildScreen(),
    );
  }
}
