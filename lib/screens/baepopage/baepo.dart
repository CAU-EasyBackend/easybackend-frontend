import 'dart:typed_data'; // Import the dart:typed_data library for Uint8List
import 'package:easyback/screens/baepopage/sangtae.dart';
import 'package:easyback/screens/main_menu.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart'; // file_picker 라이브러리
import '../mainpage/ApiPage.dart';
import '../mainpage/Deployment.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // JSON 디코딩 패키지

class Baepo extends StatefulWidget {
  const Baepo({Key? key}) : super(key: key);

  @override
  State<Baepo> createState() => _BaepoState();
}

class _BaepoState extends State<Baepo> {
  Color buttonColor1 = Colors.black;
  Color buttonColor2 = Colors.black;
  Color buttonColor3 = Colors.black;
  String? centerText;
  String showFileName = "";
  String userInput = "";
  Color defaultColor = Colors.grey[400]!;

  bool checkBox1 = false;
  bool checkBox2 = false;
  bool fileUploadEnabled = true;
  bool textFieldEnabled = true;
  String fileContent = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      buttonColor2 = Colors.white12;
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
                          _handleDeploymentGuideButton(context);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: buttonColor1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        child: Text('배포 가이드'),
                      ),
                    ),
                    SizedBox(height: 0),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          _handleFileUploadButton(context);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: buttonColor2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                            side: BorderSide(color: Colors.white),
                          ),
                        ),
                        child: Text('파일 업로드'),
                      ),
                    ),
                    SizedBox(height: 0),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          _handleSangtaeButton(context);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: buttonColor3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                            side: BorderSide(color: Colors.white, width: 1),
                          ),
                        ),
                        child: Text('상태관리'),
                      ),
                    ),
                    SizedBox(height: 100),
                  ],
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 50),
                      Text(
                        '파일 업로드 방식을 선택해주세요.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: 30),
                      Row(
                        children: [
                          SizedBox(width: 170),
                          Expanded(
                            child: makeFilePicker(),
                          ),
                          SizedBox(width: 30),
                          SizedBox(width: 100),
                          Expanded(
                            child: Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                TextField(
                                  enabled: textFieldEnabled,
                                  onChanged: (value) {
                                    setState(() {
                                      userInput = value;
                                      fileUploadEnabled = userInput.isEmpty;
                                    });
                                    getFileFromGitHub(userInput);
                                  },
                                  decoration: InputDecoration(
                                    hintText: '   GitHub URL...',
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    getFileFromGitHub(userInput);
                                  },
                                  icon: Icon(Icons.arrow_forward),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 200),
                        ],
                      ),
                      SizedBox(height: 40),
                      Text(
                        '코드 생성을 위한 프레임 워크를 선택해주세요.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(width: 550),
                          Theme(
                            data: ThemeData(
                              unselectedWidgetColor: Colors.white,
                            ),
                            child: Checkbox(
                              value: checkBox1,
                              onChanged: (bool? value) {
                                setState(() {
                                  checkBox1 = value!;
                                  if (checkBox1) checkBox2 = false;
                                });
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
                              value: checkBox2,
                              onChanged: (bool? value) {
                                setState(() {
                                  checkBox2 = value!;
                                  if (checkBox2) checkBox1 = false;
                                });
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
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // 배포하기 버튼 클릭 시 수행할 작업 추가
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                          child: Text(
                            "배포하기",
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container makeFilePicker() {
    return Container(
      height: 170,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['zip'],
              );
              if (result != null && result.files.isNotEmpty) {
                String fileName = result.files.first.name;
                Uint8List fileBytes = result.files.first.bytes!;
                debugPrint(fileName);
                setState(() {
                  showFileName = "Now File Name: $fileName";
                  textFieldEnabled = false;
                });
                getFileFromGitHub(userInput);
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 50),
                Text(
                  "Find and Upload",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: defaultColor,
                    fontSize: 20,
                  ),
                ),
                Icon(
                  Icons.upload_rounded,
                  color: defaultColor,
                ),
              ],
            ),
          ),
          Text("(*.zip)", style: TextStyle(color: defaultColor)),
          const SizedBox(height: 10),
          Expanded(
            child: Text(
              showFileName,
              style: TextStyle(color: defaultColor),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                showFileName = "";
              });
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.grey,
              onPrimary: Colors.white,
            ),
            child: Text('Cancel Upload'),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  void getFileFromGitHub(String url) async {
    try {
      var apiUrl = Uri.parse('https://github.com/CAU-EasyBackend/easybackend-server/blob/241129a21eeb17953ab09d148381c5ddd090b8ed/.gitignore');
      var requestBody = jsonEncode({'repositoryURL': url});
      var response = await http.post(
        apiUrl,
        headers: {'Content-Type': 'application/json'},
        body: requestBody,
      );

      if (response.statusCode == 200) {
        setState(() {
          fileContent = response.body;
        });
      } else {
        setState(() {
          fileContent = "Failed to fetch file: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        fileContent = "Error: $e";
      });
    }
  }

  void _handleDeploymentGuideButton(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Deployment()),
    );
  }

  void _handleFileUploadButton(BuildContext context) {
    // Add functionality for file upload button
  }

  void _handleSangtaeButton(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Sangtae()),
    );
  }
}
