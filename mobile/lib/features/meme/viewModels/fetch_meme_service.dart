import 'package:mobile/features/meme/models/meme_response_model.dart';
import 'package:mobile/utils/http/http_init.dart';

class FetchMemeService {

  static Future<MemeResponseModel> getAllMemes() async {
    return await DefaultRequestSettings.get<MemeResponseModel>(
      endpoint: "/meme/",
      fromJson: (data) => MemeResponseModel.fromJson(data),
    );
  }
}

