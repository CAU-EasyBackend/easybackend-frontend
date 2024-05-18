class ServerVersion {
  final int version;
  final int? port;
  final String? description;

  ServerVersion.fromJson(Map<String, dynamic> json)
      : version = json['version'],
        port = json['port'],
        description = json['description'];
}
