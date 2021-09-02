import 'package:authentification/bookInfo.dart';
import 'package:authentification/database.dart';
import 'package:authentification/screens/edit_information.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageTest extends StatefulWidget {
  const ImageTest({Key? key}) : super(key: key);

  @override
  _ImageTestState createState() => _ImageTestState();
}

class _ImageTestState extends State<ImageTest> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: EditInfor(
        text: Database.thisUserInfo.Id,
      ),
    );
  }
}
