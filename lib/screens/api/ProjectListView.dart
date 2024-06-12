import 'package:easyback/models/APISpec.dart';
import 'package:flutter/material.dart';

class ProjectListView extends StatelessWidget {
  final List<APISpec> projects;
  final Function(APISpec?) handleProjectTap;

  ProjectListView({
    required this.projects,
    required this.handleProjectTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: projects.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            projects[index].projectName,
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
          onTap: () {
            handleProjectTap(projects[index]);
          },
        );
      },
    );
  }
}
