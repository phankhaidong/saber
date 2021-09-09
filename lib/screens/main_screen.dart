import 'package:authentification/Models/bookInfo.dart';
import 'package:authentification/Models/database.dart';
import 'package:authentification/Models/post_base.dart';
import 'package:authentification/Widget/connectivity_provider.dart';

import 'package:authentification/screens/createPost.dart';
import 'package:authentification/screens/home.dart';
import 'package:authentification/screens/library.dart';
import 'package:authentification/screens/notification.dart';
import 'package:authentification/screens/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../reybo_app_icons.dart';
import 'no_internet.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  void initState() {
    super.initState();
    Database.bookBase = BookBase();
    Database.bookBase.initialize();
    Database.bookBase.read().then((value) => {
          setState(() {
            Database.books = value;
          })
        });

    Database.postBase = PostBase();
    Database.postBase.initialize();
    Database.postBase.read().then((value) => {
          setState(() {
            Database.posts = value;
          })
        });
  }

  int currentIndex = 2;
  final screens = [
    CreatePostScreen(),
    LibraryScreen(),
    HomeScreen(),
    NotificationsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    //Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
    return Scaffold(
      body: Consumer<ConnectivityProvider>(
        builder: (context, model, child) {
          if (model.isOnline == false || model.isOnline == true) {
            return model.isOnline
                ? Scaffold(
                    body: IndexedStack(
                      index: currentIndex,
                      children: screens,
                    ),
                  )
                : NoInternet();
          }
          return Container(
            child: Center(),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: HexColor("50C2C9"),
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        currentIndex: currentIndex,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        iconSize: 30,
        onTap: (index) => setState(() => currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(ReyboApp.pencil),
            label: 'pencil',
          ),
          BottomNavigationBarItem(
            icon: Icon(ReyboApp.readlist),
            label: 'readlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(ReyboApp.home),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(ReyboApp.bell),
            label: 'bell',
          ),
          BottomNavigationBarItem(
            icon: Icon(ReyboApp.profile),
            label: 'profile',
          ),
        ],
      ),
    );
  }
}
