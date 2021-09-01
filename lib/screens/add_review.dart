import 'package:authentification/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class AddReview extends StatefulWidget {
  final String bookCode;
  const AddReview({Key? key, required this.bookCode}) : super(key: key);

  @override
  _AddReviewState createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  late String isbn = widget.bookCode;
  late TextEditingController _textEditingController;
  // cai nay chua bai review
  String text = "";
  CollectionReference review_posts =
      FirebaseFirestore.instance.collection('reviewpost');
  CollectionReference user = FirebaseFirestore.instance.collection('users');
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    _textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(color: Colors.black);

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          //get user id
          //add idPost to user work list
          var emptyList = [];
          String idpost = Database.thisUserInfo.Fullname +
              DateTime.now().year.toString() +
              DateTime.now().month.toString() +
              DateTime.now().day.toString() +
              DateTime.now().hour.toString() +
              DateTime.now().minute.toString() +
              DateTime.now().second.toString();
          review_posts.doc(idpost).set({
            'ISBN': isbn,
            'Commenters': FieldValue.arrayUnion(emptyList),
            'Likers': FieldValue.arrayUnion(emptyList),
            'Comments': FieldValue.arrayUnion(emptyList),
            'Comment_count': 0.toInt(),
            'Like_count': 0.toInt(),
            'Created': DateTime.now(),
            'Content': text,
            'View': 0.toInt(),
            'Owner': Database.thisUserInfo.Fullname,
          });
          user.doc(Database.thisUserInfo.Id).update({
            'Works_list': FieldValue.arrayUnion([idpost]),
          });
          //increase book's review_counter using stream builder ?
          //increase user works counter
          Navigator.of(context).pop();
        },
        label: const Text('Post'),
        icon: const Icon(Icons.thumb_up),
        backgroundColor: Colors.blue.shade200,
      ),
      appBar: AppBar(
        title: Text(
          "Create a review",
          style: style,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _controller,
          tabs: [
            Tab(
              child: Text(
                "Editing",
                style: style,
              ),
            ),
            Tab(
              child: Text(
                "Review",
                style: style,
              ),
            )
          ],
        ),
      ),
      body: Container(
        child: TabBarView(
          controller: _controller,
          children: [
            //Icon(Icons.add),
            Container(
              margin: EdgeInsets.all(20),
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: _textEditingController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText:
                      "# to add header 1\n## to header 2\n### to header 3",
                ),
                onChanged: (String newText) {
                  setState(() {
                    this.text = newText;
                  });
                },
              ),
            ),
            Container(
                height: 250,
                margin: EdgeInsets.all(20),
                child: MarkdownBody(
                  data: text,
                )),
          ],
        ),
      ),
    );
  }
}
