import 'dart:convert';
import '../models/Instance.dart';
import 'package:http/browser_client.dart';

class APIDeployInfos {
  static const String baseUrl = 'http://localhost:8080/api';

  static Future<List<Instance>> getDeployInfos() async {
    final url = Uri.parse('$baseUrl/deployInfos/statusAll');
    final client = BrowserClient()..withCredentials = true;
    final response = await client.get(
        url,
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
    );

    if(response.statusCode != 200) {
      throw Exception('Failed to load deploy infos');
    }

    final dynamic body = jsonDecode(response.body);
    final dynamic result = body['result'];
    final List<Instance> instances = (result['instances'] as List)
        .map((e) => Instance.fromJson(e))
        .toList();

    return instances;
  }
}
