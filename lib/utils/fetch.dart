import 'dart:convert';
import 'package:http/http.dart' as http;

typedef FromJson<T> = T Function(Map<String, dynamic> json);

class Fetch {
  static const String baseUrl = "http://localhost:3000";
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  /// Build Uri dari endpoint + query params
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

  /// Core request handler → dipakai semua method (DRY)
  static Future<T> _request<T>(
    Future<http.Response> Function() sendRequest, {
    T Function(dynamic json)? fromJson,
  }) async {
    final response = await sendRequest();

    final statusCode = response.statusCode;
    dynamic body;

    try {
      body = response.body.isNotEmpty ? jsonDecode(response.body) : null;
    } catch (e) {
      body = response.body; // fallback kalau bukan JSON
    }

    // Jika ada fromJson, langsung map body
    if (statusCode >= 200 && statusCode < 300) {
      if (fromJson != null && body != null) {
        return fromJson(body);
      }
      return body as T;
    } else {
      // status error → tetap kembalikan body agar Flutter bisa baca message
      if (fromJson != null && body != null) {
        return fromJson(body);
      }
      return body as T; // body biasanya Map<String, dynamic> dari server
    }
  }

  /// GET → bisa untuk single / list
  static Future<T> get<T>(
    String endpoint, {
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
    T Function(dynamic json)? fromJson,
  }) {
    final uri = _buildUri(endpoint, queryParameters);
    return _request(
      () => http.get(uri, headers: {...defaultHeaders, ...?headers}),
      fromJson: fromJson,
    );
  }

  /// ========== GET ONE ==========
  static Future<T> getOne<T>(
    String endpoint, {
    required FromJson<T> fromJson,
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
  }) {
    return get<T>(
      endpoint,
      queryParameters: queryParameters,
      headers: headers,
      fromJson: (json) => fromJson(json as Map<String, dynamic>),
    );
  }

  /// ========== GET LIST ==========
  static Future<List<T>> getList<T>(
    String endpoint, {
    required FromJson<T> fromJson,
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
  }) {
    return get<List<T>>(
      endpoint,
      queryParameters: queryParameters,
      headers: headers,
      fromJson: (json) => (json as List)
          .map((item) => fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  /// POST
  static Future<T> post<T>(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    T Function(dynamic json)? fromJson,
  }) {
    final uri = _buildUri(endpoint);
    return _request(
      () => http.post(
        uri,
        headers: {...defaultHeaders, ...?headers},
        body: jsonEncode(body ?? {}),
      ),
      fromJson: fromJson,
    );
  }

  /// PUT
  static Future<T> put<T>(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    T Function(dynamic json)? fromJson,
  }) {
    final uri = _buildUri(endpoint);
    return _request(
      () => http.put(
        uri,
        headers: {...defaultHeaders, ...?headers},
        body: jsonEncode(body ?? {}),
      ),
      fromJson: fromJson,
    );
  }

  /// DELETE
  static Future<T> delete<T>(
    String endpoint, {
    Map<String, String>? headers,
    T Function(dynamic json)? fromJson,
  }) {
    final uri = _buildUri(endpoint);
    return _request(
      () => http.delete(uri, headers: {...defaultHeaders, ...?headers}),
      fromJson: fromJson,
    );
  }
}

class HTTP {
  static const String baseUrl = "http://10.0.2.2:3000";
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
