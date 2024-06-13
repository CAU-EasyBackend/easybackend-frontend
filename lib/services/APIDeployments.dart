import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:http/browser_client.dart';
import 'package:http/http.dart' as http;

class APIDeployments {
  static const String baseUrl = 'http://localhost:8080/api';

  static Future<void> deployNewServerZip(PlatformFile file, String frameworkType) async {
    final url = Uri.parse('$baseUrl/deployments/new/zip');
    final client = BrowserClient()..withCredentials = true;

    final request = http.MultipartRequest('POST', url);
    request.headers['X-Requested-With'] = 'XMLHttpRequest';
    request.files.add(
      http.MultipartFile.fromBytes(
        'zipFile',
        file.bytes!.cast<int>(),
        filename: file.name,
      ),
    );
    request.fields['frameworkType'] = frameworkType;

    final response = await client.send(request);
    if(response.statusCode != 200) {
      throw Exception('Error');
    }

    return;
  }

  static Future<void> updateServerZip(String instanceId, PlatformFile file, String frameworkType) async {
    final url = Uri.parse('$baseUrl/deployments/$instanceId/update/zip');
    final client = BrowserClient()..withCredentials = true;

    final request = http.MultipartRequest('PATCH', url);
    request.headers['X-Requested-With'] = 'XMLHttpRequest';
    request.files.add(
      http.MultipartFile.fromBytes(
        'zipFile',
        file.bytes!.cast<int>(),
        filename: file.name,
      ),
    );
    request.fields['frameworkType'] = frameworkType;

    final response = await client.send(request);
    if(response.statusCode != 200) {
      throw Exception('Error');
    }

    return;
  }

  static Future<void> deployNewServerGithub(String repositoryURL, String frameworkType) async {
    final url = Uri.parse('$baseUrl/deployments/new/github');
    final client = BrowserClient()..withCredentials = true;

    final requestBody = jsonEncode({
      'repositoryURL': repositoryURL,
      'frameworkType': frameworkType,
    });

    final response = await client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'X-Requested-With': 'XMLHttpRequest'
        },
        body: requestBody,
    );

    if(response.statusCode != 200) {
      throw Exception('Error');
    }

    return;
  }

  static Future<void> updateServerGithub(String instanceId, String repositoryURL, String frameworkType) async {
    final url = Uri.parse('$baseUrl/deployments/$instanceId/update/github');
    final client = BrowserClient()..withCredentials = true;

    final requestBody = jsonEncode({
      'repositoryURL': repositoryURL,
      'frameworkType': frameworkType,
    });

    final response = await client.patch(
      url,
      headers: {
        'Content-Type': 'application/json',
        'X-Requested-With': 'XMLHttpRequest'
      },
      body: requestBody,
    );

    if(response.statusCode != 200) {
      throw Exception('Error');
    }

    return;
  }

  static Future<bool> versionManage(String instanceId, String selectedVersion) async {
    final url = Uri.parse('$baseUrl/deployments/$instanceId/versionManage/$selectedVersion');
    final client = BrowserClient()..withCredentials = true;

    final response = await client.patch(
      url,
      headers: {
        'X-Requested-With': 'XMLHttpRequest'
      },
    );

    if(response.statusCode != 200) {
      throw Exception('Error');
    }

    return true;
  }

  static Future<bool> checkServerAlive(String instanceId) async {
    final url = Uri.parse('$baseUrl/deployments/$instanceId/status/server');
    final client = BrowserClient()..withCredentials = true;

    final response = await client.get(
      url,
      headers: {
        'X-Requested-With': 'XMLHttpRequest'
      },
    );

    if(response.statusCode != 200) {
      throw Exception('Error');
    }

    final dynamic body = jsonDecode(response.body);
    final bool isAlive = body['result'];

    return isAlive;
  }

  static Future<bool> terminateServer(String instanceId) async {
    final url = Uri.parse('$baseUrl/deployments/$instanceId/terminate/server');
    final client = BrowserClient()..withCredentials = true;

    final response = await client.post(
      url,
      headers: {
        'X-Requested-With': 'XMLHttpRequest'
      },
    );

    if(response.statusCode != 200) {
      return false;
    }
    return true;
  }
}
