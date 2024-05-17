import 'ServerVersion.dart';

class Server {
  final String serverId;
  final String serverName;
  final int runningVersion;
  final int latestVersion;
  final int? port;
  final List<ServerVersion> serverVersions;

  Server.fromJson(Map<String, dynamic> json)
      : serverId = json['server']['serverId'],
        serverName = json['server']['serverName'],
        runningVersion = json['server']['runningVersion'],
        latestVersion = json['server']['latestVersion'],
        port = json['server']['port'],
        serverVersions = (json['serverVersions'] as List)
            .map((e) => ServerVersion.fromJson(e))
            .toList();
}
