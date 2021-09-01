import 'package:authentification/database.dart';
import 'package:authentification/screens/main_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../connectivity_provider.dart';

class SignUpSuccess extends StatefulWidget {
  const SignUpSuccess({
    Key? key,
  }) : super(key: key);
  @override
  _SignUpSuccessState createState() => _SignUpSuccessState();
}

class _SignUpSuccessState extends State<SignUpSuccess> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

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
              padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: Text(
                'Sign up succesful!',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PublicSans'),
              ),
            ),
            Padding(
              padding: EdgeInsets.zero,
              child: Image(
                image: AssetImage("images/guy.png"),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: RichText(
                text: TextSpan(
                    text: 'Hello ',
                    style: TextStyle(
                      fontFamily: 'PublicSans',
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: Database.thisUserInfo.Fullname,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ]),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: RichText(
                text: TextSpan(
                    text: 'Welcome to ',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'PublicSans',
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    children: [
                      TextSpan(
                          text: 'Reybo',
                          style: TextStyle(
                            fontFamily: 'PublicSans',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: HexColor("50C2C9"),
                          ))
                    ]),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(40, 80, 40, 20),
              child: ElevatedButton(
                  child: Text(
                    'Continue',
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                      shadowColor: Colors.grey[500],
                      minimumSize: Size(239, 50),
                      primary: HexColor("50C2C9"),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      )),
                  onPressed: () {
                    Consumer<ConnectivityProvider>(
                      builder: (context, model, child) {
                        if (model.isOnline == false || model.isOnline == true) {
                          return model.isOnline
                              ? Text("haylo")
                              : AlertDialog(
                                  title: Text("Sign up failed"),
                                  content: Text(
                                      "Sorry, an unexpected error ocur. Please check your network connection."),
                                  actions: <Widget>[
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Ok"))
                                  ],
                                );
                        }
                        return Container(
                          child: Center(),
                        );
                      },
                    );
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => MainScreen()));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
