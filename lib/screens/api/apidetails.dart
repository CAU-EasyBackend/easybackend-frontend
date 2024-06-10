import 'package:easyback/models/APISpec.dart';
import 'package:easyback/models/OpenAPISpec.dart';
import 'package:easyback/screens/api/ProjectListView.dart';
import 'package:easyback/screens/main_menu.dart';
import 'package:easyback/services/APIOpenAPISpec.dart';
import 'package:easyback/services/APIProjects.dart';
import 'package:flutter/material.dart';
import 'ApiPage.dart';
import 'apicode.dart';

class apidetails extends StatefulWidget {
  apidetails({Key? key}) : super(key: key);

  @override
  State<apidetails> createState() => _apidetailsState();
}

class _apidetailsState extends State<apidetails> {
  // final controller = Webview;
  // final WebviewController _webviewController = WebviewController();
  Color buttonColor1 = Colors.black;
  Color buttonColor2 = Colors.black;
  Color buttonColor3 = Colors.black;
  Color buttonColor4 = Colors.black;
  Color buttonColor5 = Colors.black;
  Color buttonColor6 = Colors.black;
  Color buttonColor7 = Colors.black;
  Color buttonColor8 = Colors.black;
  String? centerText;
  String showFileName = ""; // 선택된 파일 이름을 표시할 변수
  String userInput = ""; // 사용자 입력을 저장할 변수
  Color defaultColor = Colors.grey[400]!; // 기본 색상 설정

  bool showSwaggerUI = false;
  bool checkBox1 = false;
  bool checkBox2 = false;
  bool fileUploadEnabled = true;
  bool textFieldEnabled = true;
  String fileContent = ""; // 파일 내용을 저장할 변수 추가

  List<APISpec> projects = [];
  APISpec? selectedProject;
  OpenAPISpec? openAPISpec;
  Operation? selectedOperation;

  @override
  void initState() {
    super.initState();
    _getProjects();

    setState(() {
      buttonColor2 = Colors.white38;
    });
  }

  Future<void> _getProjects() async {
    final List<APISpec> projects = await APIProjects.getProjectList();
    setState(() {
      this.projects = projects;
    });
  }

  void _handleButtonPress(int buttonIndex) {
    setState(() {
      buttonColor1 = Colors.white38;
      buttonColor2 = buttonIndex == 2 ? Colors.white38 : Colors.black;
      buttonColor3 = buttonIndex == 3 ? Colors.white38 : Colors.black;
      buttonColor4 = buttonIndex == 4 ? Colors.white38 : Colors.black;
      buttonColor5 = buttonIndex == 5 ? Colors.white38 : Colors.black;
      buttonColor6 = buttonIndex == 6 ? Colors.white38 : Colors.black;
      buttonColor7 = buttonIndex == 7 ? Colors.white38 : Colors.black;
      buttonColor8 = buttonIndex == 8 ? Colors.white38 : Colors.black;
    });
  }  void _handlePlusButton() {
    print("Plus button pressed");
  }

  void _handleDeleteButton() {
    print("Delete button pressed");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: MainMenu(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
        children: [
          SizedBox(height: 50),
          Row(
            children: [
              SizedBox(width: 20),
              Container(
                width: 200, // 첫 번째 컨테이너의 너비를 설정
                height: 500,
                decoration: BoxDecoration(
                  color: Colors.black, // 배경색을 검정으로 설정
                  borderRadius: BorderRadius.circular(10), // 테두리의 모서리를 둥글게 설정
                  border: Border.all(color: Colors.white, width: 2), // 테두리를 흰색으로 설정
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
                  children: [
                    SizedBox(height: 2),
                    SizedBox(
                      width: double.infinity, // 버튼의 너비를 컨테이너의 너비와 동일하게 설정
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          _handleapiguideButton(context); // 배포 가이드 버튼 클릭 시 이동하는 함수 호출
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: buttonColor1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero, // 직각 테두리로 설정
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
                        onPressed: () async {
                          //await APIOpenAPISpec.getAPIObject('664fe646f67ab0617034fd56');
                          setState(() {
                            showSwaggerUI = true; // Swagger UI를 보여줄 상태를 true로 설정합니다.
                          });
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
                      width: double.infinity, // 버튼의 너비를 컨테이너의 너비와 동일하게 설정
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          _handleapicodeButton(context); // 배포 가이드 버튼 클릭 시 이동하는 함수 호출
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
                  width: 200, // 첫 번째 컨테이너의 너비를 설정
                  height: 500,//컨테이너 3
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
                  children: [
                    SizedBox(
                      height: 400,
                      width: 200,
                      child: ProjectListView(
                        projects: projects,
                        handleProjectTap: _handleProjectTap,
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: double.infinity,
                          height: 100,
                          color: Colors.black, // 컨테이너 색상 설정
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(Icons.add, color: Colors.white),
                                onPressed: _handlePlusButton,
                              ),
                              SizedBox(width: 10),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.white),
                                onPressed: _handleDeleteButton,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20),
              Container(
                width: 200,
                height: 500,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center, // 왼쪽 정렬
                  children: [
                    SizedBox(height: 10),
                    const Text(
                      'Server URL',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    TextField(
                      controller: TextEditingController(
                        text: openAPISpec?.servers.servers[0].url,
                      ),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 10),
                    const Text(
                      'API List',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 300,
                      width: 200,
                      child: selectedProject != null
                          ? ListView(
                        children: (openAPISpec?.paths.paths.entries.map((entry) {
                          String path = entry.key;
                          Path pathObject = entry.value;
                          return ExpansionTile(
                            title: Text(
                              path,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            children: pathObject.operations.entries.map((opEntry) {
                              String method = opEntry.key;
                              Operation operation = opEntry.value;
                              return ListTile(
                                title: Text(
                                  method,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  )
                                ),
                                onTap: () {
                                  setState(() {
                                    selectedOperation = operation;
                                  });
                                },
                              );
                            }).toList(),
                          );
                        }).toList()) ?? [],
                      ) : Container(),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          color: Colors.black, // 컨테이너 색상 설정
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(Icons.add, color: Colors.white),
                                onPressed: _handlePlusButton,
                              ),
                              SizedBox(width: 10),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.white),
                                onPressed: _handleDeleteButton,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 500,
                      width: 850,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 20), // 중간 공백

                            Container(
                              width: 700,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  '룰루 ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20), // 중간 공백

                            SizedBox(height: 20), // 중간 공백 추가
                            Container(
                              width: 700,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  '룰루 ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),


                            ),
                            SizedBox(height: 20), // 중간 공백

                          ],
                        ),
                      ),
                    ),
                    // 중간 공백

                  ],
                ),
              )

            ],
                ),
    ]
    ),
    );
  }

  Future<void> _handleProjectTap(APISpec? project) async {
    final OpenAPISpec openAPISpec = await APIOpenAPISpec.getAPIObject(project!.projectId);
    setState(() {
      selectedProject = project;
      this.openAPISpec = openAPISpec;
      selectedOperation = null;
    });
  }

  void _handleapiguideButton(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ApiPage()),
    );
  }

  void _handleapicodeButton(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => apicode()), // Deployment 페이지로 이동
    );
  }
}
