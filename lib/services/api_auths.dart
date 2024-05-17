import 'dart:convert';
import 'dart:html' as html;
import 'package:http/http.dart' as http;

class APIAuths {
  static const String baseUrl = 'http://localhost:8080/api';

  static Future<void> getLogin() async {
    const String url = "$baseUrl/auths/login";
    html.window.location.href = url;
  }
}
