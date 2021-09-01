class Notif {
  final DateTime dateTime;
  final String who;
  final String type;
  bool watched;
  late final String
      post_code; //passing this value to navigate to post view screen
  Notif(this.post_code, this.dateTime, this.who, this.type, this.watched);
}
