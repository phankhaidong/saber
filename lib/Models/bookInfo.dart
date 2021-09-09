import 'package:cloud_firestore/cloud_firestore.dart';

class BookBase {
  late FirebaseFirestore firestore;
  initialize() {
    firestore = FirebaseFirestore.instance;
  }

  Future<List> read() async {
    List books = [];
    QuerySnapshot querySnapshot;
    try {
      querySnapshot = await firestore.collection('bookBase').get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          Map book = {
            "isbn": doc.id,
            "Author": doc['Author'],
            "Image_url": doc['Image_url'],
            //"Language": doc['Language'],
            //"Rate": doc['Rate'].toString(),
            "Review_count": doc['Review_count'],
            //"lTags": doc['Tags'],
            "Title": doc['Title']
          };
          books.add(book);
        }
      }
    } catch (error) {
      print(error.toString());
    }
    return books;
  }
}
