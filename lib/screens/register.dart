import 'package:authentification/Models/database.dart';
import 'package:authentification/Models/user_info.dart';

import 'package:authentification/screens/signin.dart';
import 'package:authentification/screens/signupsuccess.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confpasswordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //String _email = '', _password = '', _cpassword = '';
  bool _validate = false;
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
              //'Welcome Onboard!'
              padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Text(
                'Welcome Onboard!',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PublicSans'),
              ),
            ),
            Padding(
              //"Let's help you meet up your tasks"
              padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: Text(
                "Let's help you meet up your tasks",
                style: TextStyle(fontSize: 13, fontFamily: 'PublicSans'),
              ),
            ),
            Padding(
                //Enter Fullname
                padding: EdgeInsets.fromLTRB(30, 35, 30, 0),
                child: TextFormField(
                  controller: _usernameController,
                  validator: (val) =>
                      val!.isEmpty ? null : "Please enter your name",
                  style: TextStyle(
                    color: Colors.black87,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(30, 18, 0, 18),
                    hintText: 'Enter your full name',
                    errorText: _validate ? 'Please enter your name' : null,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide:
                          BorderSide(color: HexColor("E5E5E5"), width: 2.5),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide:
                          BorderSide(color: HexColor("E5E5E5"), width: 2.5),
                    ),
                    errorBorder: OutlineInputBorder(
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
                //Enter mail
                padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
                child: TextFormField(
                  controller: _emailController,
                  validator: (val) =>
                      val!.isEmpty ? null : "Please enter your email address",
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(30, 18, 0, 18),
                    hintText: 'Enter your email',
                    errorText: _validate ? 'Please enter your email' : null,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide:
                          BorderSide(color: HexColor("E5E5E5"), width: 2.5),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide:
                          BorderSide(color: HexColor("E5E5E5"), width: 2.5),
                    ),
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
                padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  style: TextStyle(
                    color: Colors.black87,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(30, 18, 0, 18),
                    hintText: 'Enter password',
                    errorText: _validate ? 'Please enter your pass' : null,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide:
                          BorderSide(color: HexColor("E5E5E5"), width: 2.5),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide:
                          BorderSide(color: HexColor("E5E5E5"), width: 2.5),
                    ),
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your email address";
                    } else {
                      return null;
                    }
                  },
                )),
            Padding(
                //Confirm password
                padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
                child: TextFormField(
                  obscureText: true,
                  controller: _confpasswordController,
                  style: TextStyle(
                    color: Colors.black87,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(30, 18, 0, 18),
                    hintText: 'Confirm password',
                    errorText:
                        _validate ? 'Please enter your confirm pass' : null,
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide:
                          BorderSide(color: HexColor("E5E5E5"), width: 2.5),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide:
                          BorderSide(color: HexColor("E5E5E5"), width: 2.5),
                    ),
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
              padding: EdgeInsets.fromLTRB(40, 150, 40, 0),
              child: ElevatedButton(
                  child: Text(
                    'Register',
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
                    String _email = _emailController.text.trim();
                    String _password = _passwordController.text.trim();
                    String _username = _usernameController.text.trim();
                    _register(_email, _password, _username);
                  }),
            ),
            Padding(
                // already have account -> navigate to SIGN IN
                padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: TextButton(
                  child: RichText(
                    text: TextSpan(
                      text: 'Already have an account ',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'PublicSans',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Sign in',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'PublicSans',
                              color: HexColor("50C2C9"),
                            ))
                      ],
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => SignInScreen()));
                  },
                )),
          ],
        ),
      )),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  createUser(User user) {}

  _register(String _email, String _password, String _username) async {
    setState(() {
      _emailController.text.isEmpty ? _validate = true : _validate = false;
      _passwordController.text.isEmpty ? _validate = true : _validate = false;
      _usernameController.text.isEmpty ? _validate = true : _validate = false;
    });
    try {
      //create user
      await _auth.createUserWithEmailAndPassword(
          email: _email, password: _password);
      var user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        //create user success -> sign in -> set up information
        await _auth.signInWithEmailAndPassword(
            email: _email, password: _password);
        var emptyList = [];
        Database.thisUserInfo = UserInformation(
            user.uid,
            _username,
            "",
            "",
            "1900-01-01",
            "https://images.squarespace-cdn.com/content/v1/54b7b93ce4b0a3e130d5d232/1519987020970-8IQ7F6Z61LLBCX85A65S/icon.png?format=1000w",
            0,
            0,
            0);
        Database.Auth = _auth;
        users.doc(user.uid).set({
          'Follower': FieldValue.arrayUnion(emptyList),
          'Follwing': FieldValue.arrayUnion(emptyList),
          'Works_list': FieldValue.arrayUnion(emptyList),
          'Information': {
            'Avatar':
                'https://images.squarespace-cdn.com/content/v1/54b7b93ce4b0a3e130d5d232/1519987020970-8IQ7F6Z61LLBCX85A65S/icon.png?format=1000w',
            'Full_name': _username,
            'About': "",
            'Nickname': "",
            'Birth': "1900-01-01",
            'Follower_count': 0,
            'Following_count': 0,
            'Works': 0
          }
        });
        //
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => SignUpSuccess()));
      }
    } on FirebaseAuthException catch (error) {
      Fluttertoast.showToast(
          msg: error.message.toString(), gravity: ToastGravity.TOP);
    }
  }
}
