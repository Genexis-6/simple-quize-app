import 'package:mobile/features/meme/models/meme_data.dart';

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


