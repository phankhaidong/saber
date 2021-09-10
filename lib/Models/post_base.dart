import 'package:cloud_firestore/cloud_firestore.dart';

class PostBase {
  late FirebaseFirestore firestore;
  initialize() {
    firestore = FirebaseFirestore.instance;
  }

  Future<List> read() async {
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
            "Like_count": doc['Like_count'],
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
