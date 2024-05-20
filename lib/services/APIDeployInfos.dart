import 'dart:convert';
import 'package:http/browser_client.dart';
import '../models/Instance.dart';
import 'package:http/http.dart' as http;

class APIDeployInfos {
  static Future<List<Instance>> fetchDeployInfos() async {
    final response = await http.get(Uri.parse('http://3.35.237.19:8080'));


    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      List<Instance> instances = [];
      for (var instanceData in data) {
        instances.add(Instance.fromJson(instanceData));
      }
      return instances;
    } else {
      throw Exception('Failed to fetch deploy infos');
    }
  }
}
