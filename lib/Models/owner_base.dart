import 'package:cloud_firestore/cloud_firestore.dart';

class OwnerBase {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  late FirebaseFirestore firestore;
  initialize() {
    firestore = FirebaseFirestore.instance;
  }

  Future<List> read() async {
    List posts = [];
    await readPost().then((value) => posts = value);
    List userI = [];
    List users = [];
    for (var post in posts) {
      await readUser(post['Owner']).then((value) => userI = value);
      users.add(userI[0]);
    }
    return users;
  }

  Future<List> readUser(String uid) async {
    QuerySnapshot querySnapshot;
    List infor = [];
    try {
      querySnapshot = await users.get();
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

  Future<List> readPost() async {
    QuerySnapshot querySnapshot;
    List posts = [];
    try {
      querySnapshot = await firestore.collection('reviewpost').get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          Map post = {
            "postId": doc.id,
            "Owner": doc['Owner'],
            "Comments": doc['Comments'],
            "Commenter": doc['Commenters'],
            "Like_count": doc['Like_count'].toString(),
            "Likers": doc['Likers'],
            "Comment_count": doc['Comment_count'],
            "ISBN": doc['ISBN'],
            "time": doc['Created'].toDate(),
            "Content": doc['Content'],
            "View": doc['View'],
          };
          posts.add(post);
        }
      }
    } catch (error) {
      print(error.toString());
    }
    return posts;
  }
}
