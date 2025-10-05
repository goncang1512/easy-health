import 'dart:convert';
import 'package:http/http.dart' as http;

typedef FromJson<T> = T Function(Map<String, dynamic> json);

class HTTP {
  static const String baseUrl = "https://easyhealt-backend.vercel.app";
  // static const String baseUrl = "http://10.0.2.2:3000";
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static Uri _buildUri(
    String endpoint, [
    Map<String, String>? queryParameters,
  ]) {
    if (!endpoint.startsWith('/')) {
      throw Exception(
        "Endpoint harus diawali dengan '/' → Contoh: '/products'",
      );
    }
    return Uri.parse(
      baseUrl + endpoint,
    ).replace(queryParameters: queryParameters);
  }

  static Future<dynamic> post(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    final uri = _buildUri(endpoint);
    final response = await http.post(
      uri,
      headers: {...defaultHeaders, ...?headers},
      body: jsonEncode(body ?? {}),
    );

    final decoded = jsonDecode(response.body);

    return decoded; // biarin dynamic, jangan langsung cast
  }

  static Future<dynamic> get(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    final uri = _buildUri(endpoint);
    final response = await http.get(
      uri,
      headers: {...defaultHeaders, ...?headers},
    );

    final decoded = jsonDecode(response.body);

    return decoded; // biarin dynamic, jangan langsung cast
  }

  static Future<dynamic> put(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    final uri = _buildUri(endpoint);
    final response = await http.put(
      uri,
      headers: {...defaultHeaders, ...?headers},
      body: jsonEncode(body ?? {}),
    );

    final decoded = jsonDecode(response.body);

    return decoded; // biarin dynamic, jangan langsung cast
  }

  static Future<dynamic> delete(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    final uri = _buildUri(endpoint);
    final response = await http.delete(
      uri,
      headers: {...defaultHeaders, ...?headers},
    );

    final decoded = jsonDecode(response.body);

    return decoded;
  }
}
