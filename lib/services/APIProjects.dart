import 'dart:convert';

import 'package:easyback/models/APISpec.dart';
import 'package:http/browser_client.dart';

class APIProjects {
  static const String baseUrl = 'http://localhost:8080/api';

  static Future<List<APISpec>> getProjectList() async {
    final url = Uri.parse('$baseUrl/projects/list');
    final client = BrowserClient()..withCredentials = true;
    final response = await client.get(
        url,
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
    );

    if(response.statusCode != 200) {
      throw Exception('Failed to load projects');
    }

    final dynamic body = jsonDecode(response.body);
    final dynamic result = body['result'];
    final List<APISpec> projects = (result['projects'] as List)
        .map((e) => APISpec.fromJson(e))
        .toList();

    return projects;
  }
}
