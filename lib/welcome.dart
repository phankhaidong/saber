import 'package:authentification/screens/start.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
//import 'package:provider/provider.dart';

//import 'connectivity_provider.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  // void initState() {
  //   super.initState();
  //   Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.zero,
                      child: Image(image: AssetImage("images/Ellipse 2.png")),
                    ),
                    Container(
                      padding: EdgeInsets.zero,
                      child: Image(image: AssetImage("images/Ellipse 1.png")),
                    ),
                  ],
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(40, 50, 40, 0),
              child: RichText(
                text: TextSpan(
                    text: 'Welcom to',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'PublicSans',
                        color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                          text: ' Reybo',
                          style: TextStyle(
                            fontSize: 36,
                            fontFamily: 'Rasa',
                            color: HexColor("50C2C9"),
                          ))
                    ]),
              ),
            ),
            Container(
                padding: EdgeInsets.fromLTRB(40, 80, 20, 50),
                child: Image(
                  image: AssetImage("images/start.png"),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    child: new Text(
                      'Get Started',
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                        shadowColor: Colors.grey[500],
                        minimumSize: Size(239, 58),
                        primary: HexColor("50C2C9"),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        )),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => StartScreen()));
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
