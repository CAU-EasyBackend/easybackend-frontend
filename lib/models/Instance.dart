import 'Server.dart';

class Instance {
  final String instanceId;
  final String instanceName;
  final int instanceNumber;
  final String status;
  final String? IP;
  final List<Server> servers;

  Instance.fromJson(Map<String, dynamic> json)
      : instanceId = json['instance']['instanceId'],
        instanceName = json['instance']['instanceName'],
        instanceNumber = json['instance']['instanceNumber'],
        status = json['instance']['status'],
        IP = json['instance']['IP'],
        servers = (json['servers'] as List)
            .map((e) => Server.fromJson(e))
            .toList();
}
