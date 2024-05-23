class APISpec {
  final String projectId;
  final String projectName;

  APISpec.fromJson(Map<String, dynamic> json)
      : projectId = json['projectId'],
        projectName = json['projectName'];
}
