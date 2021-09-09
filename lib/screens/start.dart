//import 'package:authentification/connectivity_provider.dart';
import 'package:authentification/screens/register.dart';
import 'package:authentification/screens/signin.dart';
import 'package:authentification/screens/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
//import 'package:provider/provider.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<StartScreen> {
  // void initState() {
  //   super.initState();
  //   Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
  // }
  final FirebaseAuth _auth = FirebaseAuth.instance;
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
            Container(
                padding: EdgeInsets.fromLTRB(20, 80, 20, 50),
                child: Image(
                  image: AssetImage("images/meow.png"),
                )),
            Padding(
              padding: EdgeInsets.fromLTRB(40, 60, 40, 30),
              child: ElevatedButton(
                  child: Text(
                    'Register',
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
                        builder: (context) => RegisterScreen()));
                  }),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(40, 10, 40, 0),
              child: ElevatedButton(
                  child: Text(
                    'Sign in',
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
                        builder: (context) => SignInScreen()));
                  }),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
                child: TextButton(
                  child: RichText(
                    text: TextSpan(
                      text: 'Try with guest account? ',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'PublicSans',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Continue',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'PublicSans',
                              color: HexColor("50C2C9"),
                            ))
                      ],
                    ),
                  ),
                  onPressed: () {
                    _auth.signInAnonymously();
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => Welcome()));
                  },
                )),
          ],
        ),
      ),
    );
  }
}
