import "dart:io";
import "package:http/http.dart" as http;
import "dart:convert";

class DefaultRequestSettings {
  static const String baseUrl = "10.0.2.2:9000";



  static Future<T> get<T>({
    required String endpoint,
    Map<String, String>? headers,
    T Function(dynamic data)? fromJson,
  }) async {
    final url = Uri.http(baseUrl, endpoint);
    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (fromJson != null) return fromJson(data);
        return data as T;
      } else {
        throw Exception(
          "GET request failed: ${response.statusCode} - ${response.reasonPhrase}",
        );
      }
    } on SocketException catch (e) {
      throw Exception("error due to $e");
    }
  }
}
