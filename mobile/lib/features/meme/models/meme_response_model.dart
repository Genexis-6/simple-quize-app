class MemeResponseModel {
  final int statusCode;
  final String message;
  final List<MemeData> data;

  MemeResponseModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory MemeResponseModel.fromJson(Map<String, dynamic> json) {
    return MemeResponseModel(
      statusCode: json['statusCode'],
      message: json['message'],
      data: List<MemeData>.from(
        json['data'].map((item) => MemeData.fromJson(item)),
      ),
    );
  }
}

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

class CachedAns {
  final String id, person;
  final bool isCorrect;

  CachedAns({required this.id, required this.person, required this.isCorrect});
}
