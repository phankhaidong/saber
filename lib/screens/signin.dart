import 'package:authentification/Models/database.dart';
import 'package:authentification/Models/user_info.dart';

import 'package:authentification/screens/main_screen.dart';
import 'package:authentification/screens/register.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String _email = '', _password = '';
  bool _passwordVisible = false;
  final auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: SingleChildScrollView(
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
                'Welcome Back!',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PublicSans'),
              ),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(30, 80, 30, 0),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    setState(() {
                      _email = value.trim();
                    });
                  },
                  style: TextStyle(
                    color: Colors.black87,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(30, 18, 0, 18),
                    hintText: 'Enter your email',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide:
                          BorderSide(color: HexColor("E5E5E5"), width: 2.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide:
                          BorderSide(color: HexColor("E5E5E5"), width: 2.5),
                    ),
                    fillColor: HexColor("E5E5E5"),
                    filled: true,
                  ),
                )),
            Padding(
                padding: EdgeInsets.fromLTRB(30, 25, 30, 0),
                child: TextField(
                  obscureText: true,
                  onChanged: (value) {
                    setState(() {
                      _password = value.trim();
                    });
                  },
                  style: TextStyle(
                    color: Colors.black87,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(30, 18, 0, 18),
                    hintText: 'Enter password',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide:
                          BorderSide(color: HexColor("E5E5E5"), width: 2.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide:
                          BorderSide(color: HexColor("E5E5E5"), width: 2.5),
                    ),
                    fillColor: HexColor("E5E5E5"),
                    filled: true,
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.visibility),
                    ),
                  ),
                )),
            Padding(
              padding: EdgeInsets.fromLTRB(40, 150, 40, 20),
              child: ElevatedButton(
                  child: Text(
                    'Sign In',
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                      shadowColor: Colors.grey[500],
                      minimumSize: Size(239, 50),
                      primary: HexColor("50C2C9"),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      )),
                  onPressed: () async {
                    try {
                      await auth.signInWithEmailAndPassword(
                          email: _email, password: _password);
                      var user = FirebaseAuth.instance.currentUser;
                      Database.Auth = auth;
                      if (user != null) {
                        print(user.uid);
                        //Database.thisUserInfo.Id = user.uid;
                        try {
                          List userI = [];
                          await read(user.uid).then((value) => userI = value);
                          Database.thisUserInfo = UserInformation(
                              user.uid,
                              userI[0]['infor']['Full_name'],
                              userI[0]['infor']['About'],
                              userI[0]['infor']['Nickname'],
                              userI[0]['infor']['Birth'],
                              userI[0]['infor']['Avatar'],
                              userI[0]['infor']['Follower_count'],
                              userI[0]['infor']['Following_count'],
                              userI[0]['infor']['Works']);
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => MainScreen()));
                        } catch (error) {
                          print(error.toString());
                        }
                      }
                      //TODO: change here
                    } on FirebaseAuthException catch (error) {
                      Fluttertoast.showToast(
                          msg: error.message.toString(),
                          gravity: ToastGravity.TOP);
                    }
                  }),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(40, 0, 135, 0),
              child: Text(
                'Forgot Password',
                style: TextStyle(
                  fontFamily: 'PublicSans',
                  fontSize: 14,
                  color: HexColor("50C2C9"),
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: TextButton(
                  child: RichText(
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'PublicSans',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Sign Up',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'PublicSans',
                              color: HexColor("50C2C9"),
                              fontWeight: FontWeight.bold,
                            ))
                      ],
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => RegisterScreen()));
                  },
                )),
          ],
        ),
      )),
    );
  }

  Future<List> read(String uid) async {
    QuerySnapshot querySnapshot;
    List infor = [];
    try {
      querySnapshot = await firestore.collection('users').get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          Map _userInfor = {
            "id_user": doc.id,
            'infor': doc["Information"],
          };
          if (_userInfor['id_user'] == uid) {
            infor.add(_userInfor);
            break;
          }
        }
      }
    } catch (error) {
      print(error.toString());
    }
    return infor;
  }
}
