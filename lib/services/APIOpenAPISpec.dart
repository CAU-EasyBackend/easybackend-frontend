import 'dart:convert';
import 'package:easyback/models/OpenAPISpec.dart';
import 'package:http/browser_client.dart';

class APIOpenAPISpec {
  static const String baseUrl = 'http://localhost:8080/api';

  static Future<OpenAPISpec> getAPIObject(String projectId) async {
    final url = Uri.parse('$baseUrl/projects/$projectId/apiSpec');
    final client = BrowserClient()..withCredentials = true;

    final response = await client.get(
        url,
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
    );

    if(response.statusCode != 200) {
      throw Exception('Failed to load API');
    }

    final dynamic body = jsonDecode(response.body);
    final OpenAPISpec openAPISpec = OpenAPISpec.fromJson(body['result']['apiSpec']);

    return openAPISpec;
  }
}
