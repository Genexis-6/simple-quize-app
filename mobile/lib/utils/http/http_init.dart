import "dart:async";
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
      final response = await http
          .get(url, headers: headers)
          .timeout(Duration(seconds: 15));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (fromJson != null) return fromJson(data);
        return data as T;
      } else {
        throw Exception(
          "GET request failed: ${response.statusCode} - ${response.reasonPhrase}",
        );
      }
    } on TimeoutException catch (_) {
      // return ResponseEnums.error;
      throw Exception("connection time out");
    } catch (_) {
      throw Exception("error occured when connecting to backend");
    }
  }
}
