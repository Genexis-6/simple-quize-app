class MemeData {
  final String person;
  final String memeText;
  final String audioFile;
  final String id;

  MemeData({
    required this.person,
    required this.memeText,
    required this.audioFile,
    required this.id
  });

  factory MemeData.fromJson(Map<String, dynamic> json) {
    return MemeData(
      id: json["id"],
      person: json['person'],
      memeText: json['meme_text'],
      audioFile: json['audio_file'],
    );
  }
}
