class Meme {
  String submissionId = '';
  String submissionUrl = '';
  String submissionTitle = '';
  String permalink = '';
  String author = '';
  String created = '';
  String timestamp = '';

  Meme(
      {required this.submissionId,
      required this.submissionUrl,
      required this.submissionTitle,
      required this.permalink,
      required this.author,
      required this.created,
      required this.timestamp});

  Meme.fromJson(Map<String, dynamic> json) {
    submissionId = json['submission_id'];
    submissionUrl = json['submission_url'];
    submissionTitle = json['submission_title'];
    permalink = json['permalink'];
    author = json['author'];
    created = json['created'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> meme = new Map<String, dynamic>();
    meme['submission_id'] = this.submissionId;
    meme['submission_url'] = this.submissionUrl;
    meme['submission_title'] = this.submissionTitle;
    meme['permalink'] = this.permalink;
    meme['author'] = this.author;
    meme['created'] = this.created;
    meme['timestamp'] = this.timestamp;
    return meme;
  }
}
