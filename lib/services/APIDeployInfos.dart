import 'dart:convert';
import 'package:http/browser_client.dart';
import '../models/Instance.dart';
import 'package:http/http.dart' as http;

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

 static Future<String> fetchLogData(String instanceId) async {
    //final url = Uri.parse('$baseUrl/deployments/66694bc71e77c23effcdcc67/logs');
    
    final url = Uri.parse('$baseUrl/deployments/$instanceId/logs');
    final client = BrowserClient()..withCredentials = true;

    try {
      final response = await client.get(
        url,
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'Content-Type': 'application/json'
        }
      );

 

      if (response.statusCode != 200) {
        throw Exception('Failed to load logs with status code: ${response.statusCode}');
      }

      final dynamic jsonResponse = jsonDecode(response.body);
      return jsonResponse['message'];
    } catch (error) {
      print('Error fetching logs: $error');
      rethrow;
    }
  }

  static Future<List<Instance>> testGetDeployInfos() async {
    final response_body = '{"success":true,"message":"성공","result":{"instances":[{"instance":{"instanceId":"663da9780b431eec968d19fe","instanceName":"keylime7-1","instanceNumber":1,"status":"running"},"servers":[{"server":{"serverId":"663da9780b431eec968d19ff","serverName":"server","runningVersion":2,"latestVersion":3},"serverVersions":[{"version":1},{"version":2},{"version":3}]}]},{"instance":{"instanceId":"663da9c60b431eec968d1a07","instanceName":"keylime7-2","instanceNumber":2,"status":"running"},"servers":[{"server":{"serverId":"663da9c60b431eec968d1a08","serverName":"server","runningVersion":1,"latestVersion":1},"serverVersions":[{"version":1}]}]}]}}';
    final dynamic body = jsonDecode(response_body);
    final dynamic result = body['result'];
    final List<Instance> instances = (result['instances'] as List)
        .map((e) => Instance.fromJson(e))
        .toList();

    return instances;
  }


}
