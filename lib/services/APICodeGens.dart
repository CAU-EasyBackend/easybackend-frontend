import 'dart:convert';
import 'package:http/browser_client.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;

class APICodeGens {
  static const String baseUrl = 'http://localhost:8080/api';

  static Future<void> generateCodeFromZip(String projectId, String frameworkType) async {
    final url = Uri.parse('$baseUrl/codeGens/zip');
    final client = BrowserClient()..withCredentials = true;

    final requestBody = jsonEncode({
      'projectId': projectId,
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

    final contentDisposition = response.headers['content-disposition'];
    final fileName = contentDisposition != null
        ? contentDisposition.split('filename=')[1].replaceAll(RegExp(r'^"|"$'), '').trim()
        : 'generated_code.zip';

    final blob = html.Blob([response.bodyBytes], 'application/zip');
    final downUrl = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = downUrl
      ..style.display = 'none'
      ..download = fileName;
    html.document.body!.children.add(anchor);

    anchor.click();

    html.document.body!.children.remove(anchor);
    html.Url.revokeObjectUrl(downUrl);

    return;
  }

  static Future<String> generateCodeFromGithub(String projectId, String frameworkType) async {
    final url = Uri.parse('$baseUrl/codeGens/github');
    final client = BrowserClient()..withCredentials = true;

    final requestBody = jsonEncode({
      'projectId': projectId,
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

    final dynamic body = jsonDecode(response.body);
    final dynamic result = body['result'];

    return result['repositoryURL'];
  }
}
