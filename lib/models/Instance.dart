import 'Server.dart';

class Instance {
  final String instanceId;
  final String instanceName;
  final int instanceNumber;
  final String status;
  final String? IP;
  final List<Server> servers;
  final String name;
  final String description;

  Instance({
    required this.instanceId,
    required this.instanceName,
    required this.instanceNumber,
    required this.status,
    required this.IP,
    required this.servers,
    required this.name,
    required this.description,
  });

  factory Instance.fromJson(Map<String, dynamic> json) {
    return Instance(
      instanceId: json['instance']['instanceId'],
      instanceName: json['instance']['instanceName'],
      instanceNumber: json['instance']['instanceNumber'],
      status: json['instance']['status'],
      IP: json['instance']['IP'],
      servers: (json['servers'] as List)
          .map((e) => Server.fromJson(e))
          .toList(),
      name: json['name'],
      description: json['description'],
    );
  }
}
