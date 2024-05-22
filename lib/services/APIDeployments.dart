import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:http/browser_client.dart';
import 'package:http/http.dart' as http;

class APIDeployments {
  static const String baseUrl = 'http://localhost:8080/api';

  static Future<void> deployNewServerZip(PlatformFile file) async {
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

    final response = await client.send(request);
    if(response.statusCode != 200) {
      throw Exception('Error');
    }

    return;
  }

  static Future<void> deployNewServerGithub(String repositoryURL) async {
    final url = Uri.parse('$baseUrl/deployments/new/github');
    final client = BrowserClient()..withCredentials = true;

    final requestBody = jsonEncode({
      'repositoryURL': repositoryURL,
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
}
