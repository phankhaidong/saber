import 'package:authentification/bookInfo.dart';
import 'package:authentification/post.dart';
import 'package:authentification/post_base.dart';
import 'package:authentification/user_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Database {
  static List books = [];
  static List posts = [];
  static late FirebaseAuth Auth;
  static late UserInformation thisUserInfo;
  static late BookBase bookBase;
  static late PostBase postBase;
  static List<Post> PostList = [
    Post(
        "0",
        "SnR",
        "One of my favourite books is Harry Potter and the Philosopher's Stone by J.K. Rowling. It is a story about Harry Potter, an orphan brought up by his aunt and uncle because his parents were killed when he was a baby. Harry is unloved by his uncle and aunt but everything changes when he is invited to join Hogwarts School of Witchcraft and Wizardry and he finds out he's a wizard. At Hogwarts Harry realises he's special and his adventures begin when he and his new friends Ron and Hermione attempt to unravel the mystery of the Philosopher's Stone",
        DateTime.now(),
        36,
        6,
        false),
    Post("1", "Diu", "Ua hong hieu", DateTime.now(), 36, 6, false),
  ];
  // void findpost(String isbn) {
  //   var result = books.indexWhere((element) => false)((element) => element['isbn'] == "");
  // }
}
