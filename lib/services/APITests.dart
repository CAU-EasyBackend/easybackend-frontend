import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/browser_client.dart';

class APITests {
  static const String baseUrl = 'http://localhost:8080/api';

  static Future<String> testAPI() async {
    final url = Uri.parse('$baseUrl/tests');
    final response = await http.get(url);

    if(response.statusCode != 200) {
      throw Exception('Failed to test API');
    }

    final dynamic body = jsonDecode(response.body);
    final String message = body['message'];

    return message;
  }

  static Future<void> testGetUserInfo() async {
    final url = Uri.parse('$baseUrl/tests/auth/userInfo');
    final client = BrowserClient()..withCredentials = true;
    final response = await client.get(
        url,
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
    );

    if(response.statusCode != 200) {
      throw Exception('Failed to get user info');
    }

    final dynamic body = jsonDecode(response.body);
    final dynamic result = body['result'];
    final String username = result['username'];

    print(username);
  }
}
