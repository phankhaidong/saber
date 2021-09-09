import 'package:authentification/Widget/notif.dart';
import 'package:authentification/Widget/postview.dart';
import 'package:authentification/reybo_app_icons.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<Notif> NotifiList = [
    Notif("0", DateTime.now(), "SnR", "commented", false),
    Notif("1", DateTime.now(), "Diu", "commented", true),
    Notif("1", DateTime.now(), "Who1", "liked", true),
  ];

  Widget notifCard(BuildContext context, int index) {
    final notif = NotifiList[index];
    Color cardColor = Colors.white;
    if (notif.watched == false) {
      cardColor = HexColor("BFE8E8");
    }
    late Icon notifType = Icon(ReyboApp.setting);
    switch (notif.type) {
      case 'liked':
        notifType = Icon(Icons.thumb_up);
        break;
      case 'commented':
        notifType = Icon(Icons.comment);
        break;
    }

    return GestureDetector(
      child: Container(
        color: cardColor,
        width: 400,
        height: 100,
        padding: EdgeInsets.fromLTRB(25, 15, 25, 15),
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Stack(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 35,
                        child: CircleAvatar(
                          //import image
                          radius: 34,
                          backgroundImage: null,
                          backgroundColor: HexColor("41BEC5"),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Ink(
                          child: notifType,
                        ),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.only(right: 15),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                          text: notif.who,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                                text: ' ' + notif.type + ' ' + 'your post',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal))
                          ]),
                    ),
                    Text(DateTime.now()
                            .difference(notif.dateTime)
                            .inMinutes
                            .toString() +
                        " minutes ago")
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      onTap: () {
        setState(() {
          notif.watched = true;
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ViewPostScreen(code: notif.post_code)));
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Notifications',
          style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'PublicSans'),
        ),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: NotifiList.length,
          itemBuilder: (BuildContext context, int index) {
            return notifCard(context, index);
          },
        ),
      ),
    );
  }
}
