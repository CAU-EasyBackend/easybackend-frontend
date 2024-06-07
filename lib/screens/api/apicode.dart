import 'package:easyback/models/APISpec.dart';
import 'package:easyback/screens/main_menu.dart';
import 'package:easyback/services/APICodeGens.dart';
import 'package:easyback/services/APIProjects.dart';
import 'package:flutter/material.dart';

import 'ApiPage.dart';
import '../baepopage/Deployment.dart';
import 'apidetails.dart';
import 'package:url_launcher/url_launcher.dart';

class apicode extends StatefulWidget {
  const apicode({Key? key}) : super(key: key);

  @override
  State<apicode> createState() => _apicodeState();
}

class _apicodeState extends State<apicode> {
  Color buttonColor1 = Colors.black;
  Color buttonColor2 = Colors.black;
  Color buttonColor3 = Colors.white38;
  Color buttonColor4 = Colors.black;
  Color buttonColor5 = Colors.black;
  Color buttonColor6 = Colors.black;
  String? centerText;
  String showFileName = "";
  String userInput = "";
  Color defaultColor = Colors.grey[400]!;

  bool isSpringSelected = false;
  bool isExpressSelected = false;
  bool isZipOptionSelected = false;
  bool isGithubOptionSelected = false;
  bool fileUploadEnabled = true;
  bool textFieldEnabled = true;
  String fileContent = "";

  List<APISpec> projects = [];
  APISpec? selectedProject;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _getProjects();
  }

  Future<void> _getProjects() async {
    final List<APISpec> projects = await APIProjects.getProjectList();
    setState(() {
      this.projects = projects;
    });
  }

  void _handleCheckboxChanged(bool? value, int group, int index) {
    setState(() {
      if (group == 1) {
        isSpringSelected = index == 1 ? value! : false;
        isExpressSelected = index == 2 ? value! : false;
      } else if (group == 2) {
        isZipOptionSelected = index == 3 ? value! : false;
        isGithubOptionSelected = index == 4 ? value! : false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: MainMenu(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(width: 20),
              Container(
                width: 200,
                height: 500,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 2),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          _handleapipageButton(context);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: buttonColor1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        child: Text('API 가이드'),
                      ),
                    ),
                    SizedBox(height: 0),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          _handleapiguideButton(context);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: buttonColor2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                            side: BorderSide(color: Colors.white),
                          ),
                        ),
                        child: Text('API 명세'),
                      ),
                    ),
                    SizedBox(height: 0),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          _handleapicodeButton(context);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: buttonColor3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                            side: BorderSide(color: Colors.white, width: 1),
                          ),
                        ),
                        child: Text('코드생성'),
                      ),
                    ),
                    SizedBox(height: 100),
                  ],
                ),
              ),
              SizedBox(width: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: SizedBox(
                  height: 500,
                  width: 200,
                  child: ProjectListView(
                    projects: projects,
                    handleProjectTap: _handleProjectTap,
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Container(
                  height: 500,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  child: _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 40),
                      Text(
                        '코드 생성 할 프로젝트 이름: ${selectedProject?.projectName ?? '선택된 프로젝트 없음'}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: 40),
                      Text(
                        '1. 코드 생성을 위한 프레임 워크를 선택해주세요.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          SizedBox(width: 400),
                          Theme(
                            data: ThemeData(
                              unselectedWidgetColor: Colors.white,
                            ),
                            child: Checkbox(
                              value: isSpringSelected,
                              onChanged: (bool? value) {
                                _handleCheckboxChanged(value, 1, 1);
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              checkColor: Colors.white,
                              fillColor: MaterialStateColor.resolveWith(
                                    (states) {
                                  if (states.contains(MaterialState.selected)) {
                                    return Colors.grey;
                                  }
                                  return Colors.transparent;
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          Text(
                            'Java Spring',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(width: 20),
                          Theme(
                            data: ThemeData(
                              unselectedWidgetColor: Colors.white,
                            ),
                            child: Checkbox(
                              value: isExpressSelected,
                              onChanged: (bool? value) {
                                _handleCheckboxChanged(value, 1, 2);
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              checkColor: Colors.white,
                              fillColor: MaterialStateColor.resolveWith(
                                    (states) {
                                  if (states.contains(MaterialState.selected)) {
                                    return Colors.grey;
                                  }
                                  return Colors.transparent;
                                },
                              ),
                            ),
                          ),
                          Text(
                            'JS Express',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 40),
                      Text(
                        '2. 코드 제공받을 방식을 선택해주세요.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: 30),
                      Row(
                        children: [
                          SizedBox(width: 350),
                          Theme(
                            data: ThemeData(
                              unselectedWidgetColor: Colors.white,
                            ),
                            child: Checkbox(
                              value: isZipOptionSelected,
                              onChanged: (bool? value) {
                                _handleCheckboxChanged(value, 2, 3);
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              checkColor: Colors.white,
                              fillColor: MaterialStateColor.resolveWith(
                                    (states) {
                                  if (states.contains(MaterialState.selected)) {
                                    return Colors.grey;
                                  }
                                  return Colors.transparent;
                                },
                              ),
                            ),
                          ),
                          Text(
                            'zip으로 다운받기',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(width: 20),
                          Theme(
                            data: ThemeData(
                              unselectedWidgetColor: Colors.white,
                            ),
                            child: Checkbox(
                              value: isGithubOptionSelected,
                              onChanged: (bool? value) {
                                _handleCheckboxChanged(value, 2, 4);
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              checkColor: Colors.white,
                              fillColor: MaterialStateColor.resolveWith(
                                    (states) {
                                  if (states.contains(MaterialState.selected)) {
                                    return Colors.grey;
                                  }
                                  return Colors.transparent;
                                },
                              ),
                            ),
                          ),
                          Text(
                            'github repositery 생성',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () async {
                          if(selectedProject == null) {
                            return;
                          }
                          if(!isSpringSelected && !isExpressSelected) {
                            return;
                          }
                          if(!isZipOptionSelected && !isGithubOptionSelected) {
                            return;
                          }

                          String frameworkType = isSpringSelected ? 'spring' : 'express';
                          setState(() {
                            _isLoading = true;
                          });
                          if(isZipOptionSelected) {
                            await APICodeGens.generateCodeFromZip(selectedProject!.projectId, frameworkType);
                          } else {
                            String url = await APICodeGens.generateCodeFromGithub(selectedProject!.projectId, frameworkType);
                            await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('GitHub URL'),
                                  content: InkWell(
                                    child: Text(url),
                                    onTap: () => launch(url),
                                  ),
                                  actions: [
                                    TextButton(
                                      child: Text('Close'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                          setState(() {
                            _isLoading = false;
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                          child: Text(
                            "코드생성하기",
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 20),
    ]
    )
    ]
      )
    );
  }

  void _handleapiguideButton(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => apidetails()),
    );
  }

  void _handleapipageButton(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ApiPage()),
    );
  }

  void _handleapicodeButton(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => apicode()),
    );
  }

  void _handleProjectTap(APISpec? project) {
    setState(() {
      selectedProject = project;
    });
  }
}

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
