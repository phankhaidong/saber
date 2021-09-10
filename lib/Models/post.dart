class Post {
  //which book
  late final String post_code;
  late final String owner_name;
  late final String content;
  late final bool is_owner;
  late DateTime date;
  late int like_count;
  late int comment_count;
  //late List<String> comments;
  //extra
  //List<String> who_comment = [];
  //List<String> who_like = [];
  Post(this.post_code, this.owner_name, this.content, this.date,
      this.like_count, this.comment_count, this.is_owner);
}
