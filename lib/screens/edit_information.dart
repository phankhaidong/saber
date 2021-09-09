import 'dart:io';
import 'package:authentification/Models/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class EditInfor extends StatefulWidget {
  final String text;
  EditInfor({Key? key, required this.text}) : super(key: key);
//Edit_Infor({Key? key, required this.text}) : super(key: key);
  @override
  _Edit_InforState createState() => _Edit_InforState();
}

late var con;

class _Edit_InforState extends State<EditInfor> {
  _Edit_InforState({Key? key});
  late var storageReference;
  late PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  bool key = false;

  //TODO: fix here
  DateTime _dateTime = DateTime.parse(Database.thisUserInfo.Birth);
  Future<Null> _selectDate(BuildContext context) async {
    DateTime? _date = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(1900),
        lastDate: DateTime(3000));
    if (_date != null && _date != _selectDate)
      setState(() {
        _dateTime = _date;
      });
  }

  Stream collectionStream =
      FirebaseFirestore.instance.collection('users').snapshots();
  final CollectionReference profile =
      FirebaseFirestore.instance.collection('users');
  List _userI = [];
  var _name = TextEditingController();
  var _nickname = TextEditingController();
  var _birth = TextEditingController();
  var _about = TextEditingController();
  late String Avatar;
  var follower_count;
  var following_count;
  var _aboutContent;
  @override
  void initState() {
    _imageFile = PickedFile('');
    Avatar = Database.thisUserInfo.Image;
    follower_count = Database.thisUserInfo.Follower_count;
    following_count = Database.thisUserInfo.Following_count;
    _aboutContent = Database.thisUserInfo.About;
    _name.text = Database.thisUserInfo.Fullname;
    _nickname.text = Database.thisUserInfo.Aka;
    _birth.text = Database.thisUserInfo.Birth;
    _about.text = Database.thisUserInfo.About;
    super.initState();
  }

  void takePhoto(ImageSource source) async {
    final picked = await _picker.getImage(source: source);
    setState(() {
      if (_imageFile != null) {
        _imageFile = picked!;
        uploadImageToFirebase();
        key = true;
      }
    });
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Text(
            "Choose photo",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                  onPressed: () {
                    takePhoto(ImageSource.camera);
                  },
                  icon: Icon(Icons.camera_alt),
                  label: Text("camera")),
              ElevatedButton.icon(
                  onPressed: () {
                    takePhoto(ImageSource.gallery);
                  },
                  icon: Icon(Icons.photo),
                  label: Text("gallery")),
            ],
          )
        ],
      ),
    );
  }

  Future uploadImageToFirebase() async {
    String fileName = basename(File(_imageFile.path).path);
    var firebaseStorageRef =
        FirebaseStorage.instance.ref().child('Avatar_user/$fileName');
    var uploadTask = firebaseStorageRef.putFile(File(_imageFile.path));
    var taskSnapshot = await uploadTask;
    taskSnapshot.ref.getDownloadURL().then((value) {
      Avatar = value.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    con = context;
    //final url =Avatar;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Information",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
          )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Center(
                    child: Stack(children: [
                  CircleAvatar(
                      radius: 80,
                      backgroundImage: key == false
                          ? NetworkImage(Avatar) as ImageProvider
                          : FileImage(File(_imageFile.path))),
                  Positioned(
                      bottom: 20,
                      right: 20,
                      child: InkWell(
                        child: Icon(
                          Icons.camera_alt,
                          size: 28,
                        ),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: ((builder) => bottomSheet()),
                          );
                        },
                      )),
                  // ElevatedButton(
                  //   child: Icon(Icons.camera),
                  //   onPressed: (){},
                  // ),
                ]));
              },
              childCount: 1,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Follower: $follower_count"),
                          Text("Following: $following_count")
                        ]),
                  ),
                );
              },
              childCount: 1,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(children: [
                      TextFormField(
                        controller: _nickname,
                        keyboardType: TextInputType.text,

                        //This will obscure text dynamically
                        decoration: InputDecoration(
                          // border: OutlineInputBorder(
                          //     borderRadius: BorderRadius.circular(30)
                          // ),
                          labelText: ' Your nickname',
                          //hintText: Infor.nickname,
                          hintText: Database.thisUserInfo.Aka,
                        ),
                      ),
                    ]),
                  ),
                );
              },
              childCount: 1,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextFormField(
                      controller: _name,
                      keyboardType: TextInputType.text,
                      //This will obscure text dynamically
                      decoration: InputDecoration(
                        // border: OutlineInputBorder(
                        //     borderRadius: BorderRadius.circular(30)
                        // ),
                        labelText: 'Your name',
                        hintText: Database.thisUserInfo.Fullname,
                      ),
                    ),
                  ),
                );
              },
              childCount: 1,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text("Your birth:",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 11))
                          ],
                        ),
                        Row(
                          children: [
                            Text(_dateTime.day.toString() +
                                "-" +
                                _dateTime.month.toString() +
                                "-" +
                                _dateTime.year.toString()),
                            IconButton(
                              icon: Icon(Icons.date_range),
                              onPressed: () {
                                setState(() {
                                  _selectDate(context);
                                  //Database.thisUserInfo.Birth = _dateTime;
                                });
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
              childCount: 1,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(children: [
                      TextFormField(
                        controller: _about,
                        keyboardType: TextInputType.text,

                        //This will obscure text dynamically
                        decoration: InputDecoration(
                            // border: OutlineInputBorder(
                            //     borderRadius: BorderRadius.circular(30)
                            // ),
                            labelText: ' Your about',
                            hintText: _aboutContent),
                      ),
                    ]),
                  ),
                );
              },
              childCount: 1,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: ElevatedButton(
                      child: Text("OK"),
                      onPressed: () {
                        String t = _dateTime.year.toString() + '-';
                        if (_dateTime.month < 10) {
                          t += '0' + _dateTime.month.toString() + '-';
                        } else
                          t += _dateTime.month.toString() + '-';
                        if (_dateTime.day < 10) {
                          t += '0' + _dateTime.day.toString();
                        } else
                          t += _dateTime.day.toString();
                        Map up = {
                          'Full_name': _name.text,
                          'Nickname': _nickname.text,
                          'Birth': t,
                          'Avatar': Avatar,
                          'About': _about.text,
                          'Follower_count': follower_count,
                          'Following_count': following_count,
                          'Works': Database.thisUserInfo.Works
                        };
                        print(Database.thisUserInfo.Id);
                        profile
                            .doc(Database.thisUserInfo.Id)
                            .update({'Information': up});
                        Navigator.pop(con);
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) => Setting()));
                      },
                    ));
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}
